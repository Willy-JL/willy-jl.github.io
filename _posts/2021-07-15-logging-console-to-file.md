---
title: Logging Console to File
date: 2021-07-15 19:44:21 +0000
categories: [Python, Snippets]
tags: [python, snippet, console, logging]
---

## Introduction
Whether you are making a program with a user interface or a commandline application, being able to catch and store console output is often crucial both for catching bugs and error messages but also to keep track of what is happening in your program.

With Python I haven't found much on the internet about achieving this, apart from a few posts talking about overriding `sys.stdout` to also write to a file, but not everything gets written to the standard output.

<br>

## The Code
This snippet is designed to be used as a standalone module, that when imported into your script will start logging the console output to a log file.
```python
# logger.py
from contextlib import contextmanager
import sys
import re

_stdout = sys.stdout
_stderr = sys.stderr
_stdin  = sys.stdin

_pause_file_output = False


def _file_write(message, no_color=True):
    if _pause_file_output:
        return
    if no_color:
        message = re.sub("\\x1b\[38;2;\d\d?\d?;\d\d?\d?;\d\d?\d?m", "", message)
        message = re.sub("\\x1b\[\d\d?\d?m",                        "", message)
    with open(f"log.txt", "a", encoding='utf-8') as log:
        log.write(message)

class __stdout_override():
    def write(self, message):
        _stdout.write(message)
        _file_write(message)

    def __getattr__(self, name):
        return getattr(_stdout, name)

class __stderr_override():
    def write(self, message):
        _stderr.write(message)
        _file_write(message)

    def __getattr__(self, name):
        return getattr(_stderr, name)

class __stdin_override():
    def readline(self):
        message = _stdin.readline()
        _file_write(message, no_color=False)
        return message

    def __getattr__(self, name):
        if name == "fileno": raise AttributeError
        return getattr(_stdin, name)

@contextmanager
def pause_file_output():
    global _pause_file_output
    _pause_file_output = True
    yield
    _pause_file_output = False
pause = pause_file_output


open("log.txt", "w").close()

sys.stdout = __stdout_override()
sys.stderr = __stderr_override()
sys.stdin  = __stdin_override ()
```

## How it works
Looking at this wall of code it might look intimidating at first but really it's quite simple.

First of all we copy the original streams onto some internal variables:
```python
_stdout = sys.stdout
_stderr = sys.stderr
_stdin  = sys.stdin
```
This way we preserve a copy of the original functionality used internally by Python

<br>

Then we define the function that ctually handles writing to the log file:
```python
def _file_write(message, no_color=True):
    if _pause_file_output:
        return
    if no_color:
        message = re.sub("\\x1b\[38;2;\d\d?\d?;\d\d?\d?;\d\d?\d?m", "", message)
        message = re.sub("\\x1b\[\d\d?\d?m",                        "", message)
    with open(f"log.txt", "a", encoding='utf-8') as log:
        log.write(message)
```
Here we instantly return if file output is paused, and then optionally remove color codes from the message. This cleans up the log file avoiding that color escape codes clutter the file, making reading the output harder. These color codes most commonly look like `\x1b[34m` where `34` is the actual color code, in this case blue (`colorama` uses these types of codes), or `\x1b[38;2;255;255;255m` where `255;255;255` are the RGB values. And finally we actually write the clean message to the `log.txt` file.

<br>

Next up are the 3 crucial parts of the script (I didn't include stderr here since it's the exact same as stdout, just with different variable names):
```python
class __stdout_override():
    def write(self, message):
        _stdout.write(message)
        _file_write(message)

    def __getattr__(self, name):
        return getattr(_stdout, name)
```
What happens here is that when the write method gets called, it calls back to the original `sys.stdout.write` functionality (remember that we backed it up inside `_stdout`) and afterwars we also write the same message to the log file. The `__getattr__` method is required since we want to keep all the other original functionality of the streams, simply modifying what we need to log output to the file, and all it does is refer back to the original stream we backed up at the start.
```python
class __stdin_override():
    def readline(self):
        message = _stdin.readline()
        _file_write(message, no_color=False)
        return message

    def __getattr__(self, name):
        if name == "fileno": raise AttributeError
        return getattr(_stdin, name)
```
With `sys.stdin` however we need to do things differently, since `stdin` is not an output stream but an input stream, it is where the user can type to give input to the program. Because of this we override the `readline` method, which also needs to return the message that was read. When writing to the file we also tell it to not remove color codes, since this is user input and if for whatever reason the user inputs a color escape code, we would still want that in the log.

In this case, however, there is also one more issue: the builtin `input()` function that we use to get input from the user by default tries to avoid using `sys.stdin.readline` and instead gets the stream number identifier with `sys.stdin.fileno` and then handles reading in C code. We don't want this however, since that means we can't log user input to the file. To overcome this we block access to `sys.stdin.fileno` by raising an `AttributeError` and this way we force `input()` to fall back to using our modified version of `sys.stdin.readline`.

<br>

The next block is an interesting one:
```python
@contextmanager
def pause_file_output():
    global _pause_file_output
    _pause_file_output = True
    yield
    _pause_file_output = False
pause = pause_file_output
```
As you might have noticed, this is the only object that doesn't start with a `_` as this is intended to be used by the user (in case you didn't know, a single `_` in front of variable/function/class names indicates that it is not intended to be used, but you can if you really have to, while a double `__` indicates mostly the same thing but to a higher degree, you should really avoid using internal members marked with two `__`). The purpose of this function if to allow pausing the file output to be paused in a `with ...():` block, meaning that while code inside such block is being executed, nothing will be output to the file. More on this later on.

<br>

Now that we set everything up, we just need to apply out overrides:
```python
open("log.txt", "w").close()
```
First of all we wipe the log file, so that every program run gets a clean log.
```python
sys.stdout = __stdout_override()
sys.stderr = __stderr_override()
sys.stdin  = __stdin_override ()
```
And finally we apply our overrides to the actual internal streams so that they become active and we start getting output in the log file.

<br>

## How to use it
Now that we understand how it all works, it's time for the fun part: actually using it!

For the best results I suggest you activate the logger as soon as possible inside your program, so that you start logging console output right from the start.
```python
from modules import logger
# First we import our logger.py, which automatically sets everything up

# Do stuff

print("this will show up in your log file!")
# Anything that gets output to the console will also be saved to the log file

with logger.pause_file_output():
    print("this will not be saved in the log file!")
    # You can also use logger.pause() for short!

msg = input("user input also gets saved: ")
# And you will see what you typed into the console right in your log file!

0/0
# This will cause an exception, but that will be caught and you will be able to see it in the log file!
```

<br>

## Updates and support
In the future if I find updates or improvements for this script I will likely update it on [this gist](https://gist.github.com/Willy-JL/3eaa171144b3bb0a4602c7b537f90036).

If you have doubts or issues, feel free to contact me! (you have many links available at the bottom of the sidebar)