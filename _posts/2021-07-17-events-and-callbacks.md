---
title: Events and Callbacks
date: 2021-07-17 16:22:04 +0000
categories: [Python, Code Better]
tags: [python, tips, code better, events and callbacks]
---

To be honest what I'm about to explain in this post is very intuitive but I had never thought about it this way and when I finally did I realized how much stuff that i wrote could be done in a much more efficient and simple way.

<br>

## The problem
Consider this example: you have a system where users can signup to your service, and when they do you need to:
 - add the user to your database
 - send the user a welcome email
 - send a notification to yourself

In this situation you might end up with something that looks a little bit like this:
```python
from modules import database
from modules import emails
from modules import discord_bot

def user_signup():
    name  = input("Please insert your name:         ")
    email = input("Please inser your email address: ")

    database.add_user(name, email)
    emails.greet_new_user(name, email)
    discord_bot.notify_new_user(name, email)
```
Sure this works fine, but when you make some changes you will end up having to change a lot of code. Also this is a simple example, but you might have some other events that happen in multiple parts of your code and that callback to many more other functions. This makes it harder to maintain the code base and also creates unnecessary code repetition.

<br>

## The solution
You can mitigate these issues by implementing an event-callback system. You assign some callbacks to an event, and when you run that event it will run all associated callbacks. Let's have a look at how we could simplify our example:
```python
from events import run_callbacks

def user_signup():
    name  = input("Please insert your name:         ")
    email = input("Please inser your email address: ")

    run_callbacks("user_joined", name, email)


# modules/database.py
from events import callback

@callback("user_joined")
def add_user(name, email):
    # Do stuff


# modules/emails.py
from events import callback

@callback("user_joined")
def greet_new_user(name, email):
    # Do stuff


# modules/discord_bot.py
from events import callback

@callback("user_joined")
def notify_new_user(name, email):
    # Do stuff
```

There are many libraries out there that allow this kind of system to be built but to be honest this is such a simple concept that I think we can do it ourselves.

<br>

## The code
So let's have a look at the code that make the above solution work:
```python
# events.py
from collections import defaultdict
import functools

events_callbacks = defaultdict(list)


def callback(event_id: str):
    def decorator_callback(func):
        functools.wraps(func)
        events_callbacks[event_id].append(func)
        return func
    return decorator_callback


def run_callbacks(event_id: str, *args):
    for func in events_callbacks[event_id]:
        func(*args)
```
And now time to explain what's happening here.

<br>

First of all we create the dictionary that will hold all of our events and the callbacks associated with them:
```python
events_callbacks = defaultdict(list)
```
We use a `defaultdict` because this way we don't need to worry about accessing some event that has no callbacks, because instead of an error it will return an empty list. Also we can simply append the callbacks without having to actually create the empty list first.

<br>

Next up is the function that allows us to use the decorators ( `@callback("name")` ):
```python
def callback(event_id: str):
    def decorator_callback(func):
        functools.wraps(func)
        events_callbacks[event_id].append(func)
        return func
    return decorator_callback
```
Decorators work in a peculiar way, I don't understand them that well myself, but this is not a tutorial on that, you can look them up yourself. What happens here is that when we apply the decorator to a function, first of all `callback` is called, allowing us to take the `event_id` argument, and then that gets passed to the standard decorator function. Here we first wrap our function, because without wrapping it the function would lose it's identity, and then we add the function to the callback list of the specified event.

<br>

And finally the function to run the callbacks of an event:
```python
def run_callbacks(event_id: str, *args):
    for func in events_callbacks[event_id]:
        func(*args)
```
As you can see this is pretty straight forward. We loop over the callbacks of the given event and we call each one of them. The only slightly unusual thing is how we handle arguments. By having `*args` in the arguments list means that any other arguments will be collected into `args` as a tuple. Then, when we call the callback we pass it as `*args`, meaning that they will be passed as individual arguments, instead of passing the whole tuple as a single argument. For example consider `run_callbacks("event", 1, 2, 3)`, inside `run_callbacks` we will have `args = (1, 2, 3)` but when we call the callback they will be expanded into `func(1, 2, 3)` instead of `func((1, 2, 3))`.

<br>

## Updates and support
In the future if I make updates or find improvements for this script I will likely update it on [this gist](https://gist.github.com/Willy-JL/b964ebe67276606c68b90e2d9fa995fd).

If you have doubts or issues, feel free to contact me! You can either use the comment section below or message me using the links at the bottom of the sidebar!
