# 从 article 文件夹读取博文列表, 更新 originl.markdown
python generate-index/generate-original.py > generate-index/original.markdown

# 将original.markdown 转为 original.html
python -m markdown -x markdown.extensions.toc -x markdown.extensions.codehilite -x markdown.extensions.tables -x markdown.extensions.smarty -x mathjax generate-index/original.markdown > generate-index/original.html

# 将 forward.markdown 转为 forward.markdown, forward.markdown由自己编辑
python -m markdown -x markdown.extensions.toc -x markdown.extensions.codehilite -x markdown.extensions.tables -x markdown.extensions.smarty -x mathjax forward.markdown > generate-index/forward.html

# 将 pre.html, original.html, mid.html, forward.html, pos.html 拼成一个 index.html
cat generate-index/pre.html > index.html
cat generate-index/original.html >> index.html
cat generate-index/mid.html >> index.html
cat generate-index/forward.html >> index.html
cat generate-index/pos.html >> index.html

# 提交更新到 github
git add --all *
git commit -m "test"
git push origin master
