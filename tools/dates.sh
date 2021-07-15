for file in _posts/YYYY-MM-DD-*.md
do
    sed -i "s/date: YYYY-MM-DD HH:MM:SS +\/-TTTT/\date: $(date -u +%Y-%m-%d\ %H:%M:%S\ %z)/" $file
    mv $file _posts/$(date -u +%Y-%m-%d)${file#_posts/YYYY-MM-DD}
done