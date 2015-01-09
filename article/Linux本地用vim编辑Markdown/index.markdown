<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/bootstrap-theme.css">
<link rel="stylesheet" href="../../css/monokai.css">
<!-- <link rel="stylesheet" href="../css/default.css"> -->

<script type="text/javascript" async="" src="../js/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/javascript">
    MathJax.Hub.Config({
        "tex2jax": { inlineMath: [ [ '$', '$' ] ] }
    });
</script>

<body>
<div class="container">

# Linux本地用vim编辑Markdown

-----------------------

>- Author: 张寅
- Email: zhyin5@gmail.com
- Date: 2015.01.08

-----------------------

[TOC]

-----------------------

## 前言

> 在线的 Markdown 编辑器各有各的缺点，还是在自己本地配一个环境，加之坚果云对所写内容的备份比较好。本文记录配置的过程，写给将来由于重装系统或换电脑的自己。

## 正文

本地编写 Markdown 的过程是:

1. 用 vim 编辑

2. 用 python-markdown 将 Markdown 解析为 Html  
为了解析出的 Html 好看, 还有需要本地的 css, 以及解析数学公式所用的js

3. 如有需要, 则用浏览器打印成pdf

### 安装 python-markdown

- 项目主页: [Python-Markdown](https://pythonhosted.org/Markdown/)
- Github网址: [waylan/Python-Markdown](https://github.com/waylan/Python-Markdown)

虽然可以用 apt-get 安装, 但为了安装的版本是最新的,还是用 git 来安装:

    git clone https://github.com/waylan/Python-Markdown.git
    cd python-markdown
    sudo python setup.py install

### 使用 python-markdown

python-markdown 可以直接在命令行使用,也可以在 python 程序中调用.

这里使用命令行的调用方式

    python -m markdown input.markdown > output.html

这样已经能解析基本的 Markdown 了,但是不能解决: **表格, 目录(TOC), 数学公式, 代码高亮**.

很棒的是 python-markdown 有很多扩展,包括官方的和第三方的.

#### 官方扩展主页: [Officially Supported Extensions](https://pythonhosted.org/Markdown/extensions/)

- 表格: markdown.extensions.tables
- TOC: markdown.extensions.toc
- 代码高亮: markdown.extensions.codehilite

命令行调用方式:

    python -m markdown -x markdown.extensions.toc -x markdown.extensions.codehilite -x markdown.extensions.tables -x markdown.extensions.smarty input.markdown > output.html

可以在 `$home/.bashrc` 中加入一行

    alias md2html='python -m markdown -x markdown.extensions.toc -x markdown.extensions.codehilite -x markdown.extensions.tables -x markdown.extensions.smarty'

然后使用时调用:

    md2html input.markdown > output.html

更方便的是在 vimrc 里增加快捷键:

    nnoremap <leader>m :!python -m markdown -x markdown.extensions.toc -x markdown.extensions.codehilite -x markdown.extensions.tables -x markdown.extensions.smarty % > %:r.html<CR>

这样在用 vim 写 Markdown 时,只要按 `,+m` 即可(我设置的leader为,)

##### codehilite 与 css

在调用的命令里加入 `-x markdown.extensions.codehilite` 之后,还不能高亮代码,需要配套的 css.

这个 css 由 pygments 生成. 很棒的是网上有别人已经生成好的各种不同高亮风格的 css, 地址: [pygments-css](http://richleland.github.io/pygments-css/)

可以将所有主题的 css 的 zip 包下载下来以后,选其中的 monokai.css 和 default.css.

每个主题的第一句都写明了代码块的背景色,如

    $ head fruity.css 
    .codehilite .hll { background-color: #333333 }
    .codehilite .c { color: #008800; font-style: italic; background-color: #0f140f } /* Comment */
    .codehilite .err { color: #ffffff } /* Error */

第一行的意思是嵌套在 class为codehilite 的标签下 class为hll 的标签的背景色为 #333333.

但是奇怪的是 python-markdown 并没有为我的代码块的 pre 标签增加 hll 的 class. 所以背景色的 css 设定失效了. 解决办法是将 `.codehilite .hll` 改为 `.codehilite` 或 `.codehilite pre`.

至此代码高亮的 css 就搞定了.

使用时指定特定语言的高亮风格: 代码块前面加一行 `:::语言`,如:

c++:

    :::c++
    #include <stdio.h>

    int main() {
        printf("Hello World!");
    }

python:

    :::python
    @requires_authorization
    def somefunc(param1='', param2=0):
        '''A docstring'''
        if param1 > param2: # interesting
            print 'Greater'
        return (param2 - param1 + 1) or None
    class SomeClass:
        pass
    >>> message = '''interpreter
    ... prompt'''

因为把内容居中显示会好看很多,所以还需要一些其他的 css. 直接用 bootstrap. 官网下载到 bootstrap.css 和 bootstrap-theme.css 后, 为了避免代码块高亮颜色的冲突,要把其中对 pre 标签的所有 color 和 background-color 的设定全都注释掉.

把 monokai.css, default.css, bootstrap.css, bootstrap-theme.css 同意放在 css 文件夹下,并在 Markdown 的文件头加上:

    :::html
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="stylesheet" href="../css/monokai.css">
    <!-- <link rel="stylesheet" href="../css/default.css"> -->

    <body>
    <div class="container">
        Markdown 正文
    </div>
    </body>

至此 css 搞定.

#### 第三方扩展主页: [list of third party extensions](https://github.com/waylan/Python-Markdown/wiki/Third-Party-Extensions)

到现在为止还没搞定数学公式的解析. python-markdown 中有对应的第三方扩展.

在 [list of third party extensions](https://github.com/waylan/Python-Markdown/wiki/Third-Party-Extensions) 中选择 [python-markdown-mathjax](https://github.com/mayoff/python-markdown-mathjax).

安装 `python-markdown-mathjax` 首先要知道 python-markdown 安装在哪里:

    $ python -c 'import markdown; print markdown.__path__[0]'
    /usr/local/lib/python2.7/dist-packages/markdown

进入得到的目录后,进入 extensions 目录,发现原来官方的扩展也都在这里.

    git clone https://github.com/mayoff/python-markdown-mathjax.git
    cd python-markdown-mathjax/
    sudo cp mdx_mathjax.py /usr/local/lib/python2.7/dist-packages/markdown/extensions/mathjax.py

现在 python-markdown 的调用更新为:

    alias md2html="python -m markdown -x markdown.extensions.toc -x markdown.extensions.codehilite -x markdown.extensions.tables -x markdown.extensions.smarty -x mathjax"

    md2html input.markdown > output.html

    nnoremap <leader>m :!python -m markdown -x markdown.extensions.toc -x markdown.extensions.codehilite -x markdown.extensions.tables -x markdown.extensions.smarty -x mathjax % > %:r.html<CR>

MathJax 本身就能识别 `$$ 公式 $$` 的情况,但是行内公式 `$ 公式 $` 需要辅助:

    :::html
    <script type="text/javascript">
        MathJax.Hub.Config({
            "tex2jax": { inlineMath: [ [ '$', '$' ] ] }
        });
    </script>

从网上下到 MathJax 的文件以后 放到 js 文件夹下,并增加:

    <script type="text/javascript" async="" src="../js/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

注意后面要加上 `?config=TeX-AMS-MML_HTMLorMML`

效果:

$$ Latexx = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

现在 Markdown 的模板变成:

    :::html
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="stylesheet" href="../css/monokai.css">
    <!-- <link rel="stylesheet" href="../css/default.css"> -->

    <script type="text/javascript" async="" src="../js/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <script type="text/javascript">
        MathJax.Hub.Config({
            "tex2jax": { inlineMath: [ [ '$', '$' ] ] }
        });
    </script>

    <body>
    <div class="container">
        Markdown正文
    </div>
    </body>

## 搞定
That's all. 搞定

完整模板:

    :::html
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="stylesheet" href="../css/monokai.css">
    <!-- <link rel="stylesheet" href="../css/default.css"> -->

    <script type="text/javascript" async="" src="../js/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <script type="text/javascript">
        MathJax.Hub.Config({
            "tex2jax": { inlineMath: [ [ '$', '$' ] ] }
        });
    </script>

    <body>
    <div class="container">

    # Title

    -----------------------

    >- Author: 张寅
    - Email: zhyin5@gmail.com
    - Date: 

    -----------------------

    [TOC]

    -----------------------

    Markdown正文

    </div>
    </body>

