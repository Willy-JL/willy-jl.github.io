cd _posts
find . -name "YYYY-MM-DD-*.md" -printf '%P\0' | while read -d $'\0' post
do
    echo $post
    echo
    sed -i "s/date: YYYY-MM-DD HH:MM:SS +\/-TTTT/\date: $(date -u +%Y-%m-%d\ %H:%M:%S\ %z)/" "$post"
    mv "$post" "$(date -u +%Y-%m-%d)${post#YYYY-MM-DD}"
done