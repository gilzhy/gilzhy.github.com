#coding=utf-8

"""
generate-index.py
@version 1.0 2015.01.11
@author Jay Young
"""
import os

articles = os.listdir("article")
for article in articles:
    if article != "Template":
        print("- [%s](%s)" % (article, os.path.join('article', article, 'index.html')))
