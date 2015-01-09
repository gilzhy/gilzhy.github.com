<link rel="stylesheet" href="../../css/bootstrap.css">
<link rel="stylesheet" href="../../css/bootstrap-theme.css">
<link rel="stylesheet" href="../../css/monokai.css">
<!-- <link rel="stylesheet" href="../../css/default.css"> -->

<script type="text/javascript" async="" src="../../js/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
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

ul:

- **粗体**
- *斜体*

ol:

1. __粗体__
啦啦啦

1. __斜体__
哈哈哈

### 链接

[百度](http://www.baidu.com)

### 图片

![啦啦](img/lala.jpg)

### 代码

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

### Latex

$ x_2 $

$$ A^2_3 $$

$$ Latexx = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

### 表格

| Item      |    Value | Qty  |
| :-------- | --------:| :--: |
| Computer  | 1600 USD |  5   |
| Phone     |   12 USD |  12  |
| Pipe      |    1 USD | 234  |

</div>
</body>
