# // Code by SoundOfSpouting#6980 (UID: 151149148639330304)
# /* hemorrhoids
#  *
#  * Copyright (C) Kamila Szewczyk, 2017-2021.
#  * License: MIT
#  * 
#  * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
#  * files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
#  * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
#  * Software is furnished to do so, subject to the following conditions:
#  * 
#  * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
#  * Software.
#  * 
#  * THE SOFTWARE IS PROVIDED "AS CUCKED", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
#  * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
#  * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#  */

# /*
#  * --------------------------------------------------------------------------------------------------------------------------
#  * A VERY VERY IMPORTANT NOTE! THIS FILE MAY SEEM OBFUSCATED OR OVERALL UNREADABLE. HERE'S WHY.
#  * Back in the day when I started the hemorrhoids project (early 2017), I thought that I'd write this reference implementation,
#  * and then write an hemorrhoids version of it, so that my self compiler actually runs the project.
#  * Later on, I thought that I'll rather write hemorrhoids in C(pip install playsound), so I froze the hemorrhoids self compiler in v0.9 and started to tweak
#  * this program, that was meant to be the reference implementation.
#  * There's no need for running away in terror, as the most of the code is just parsing the input and outputting the premade
#  * instruction microcode in the `s' string, containing instruction names and the microcode.
#  * Actually, this file is terrifying, threatening, because it is written in dirac. No FALSE speech will be tolerated. Fear it.
#  */
import sys as y
av = y.argv
if len(av) > 1:
    v1 = av[1]
    try:
        v2 = eval(v1)
    except SyntaxError: pass
import os
import re
import functools as ft
import string as st
import copy as cp
import random as rd
import math as m
from turtle import *
from PIL import Image
from playsound import playsound
ri = rd.randint
rt = lambda seq: seq[ri(0, len(seq)-1)]
N = None
_i = __import__
_b = __builtins__
_B = dir(_b)
ab = abs
al = all
an = any
bn = bin
c = chr
cx = complex
d = dict
dr = dir
em = enumerate
e = eval
x = exec
b = lambda x: lambda y: eval(x)
fm = lambda x,y: map(b(x),y)
ff = lambda x,y: filter(b(x),y)
fr = ft.reduce
fl = float
gtat = getattr
hsat = hasattr
dlat = delattr
stat = setattr
hx = hex
i = input
n = lambda *args: eval(input(*args))
sr = ""
t = int
l = len
ls = list
ot = oct
o = open
f = lambda s: o(s).read()
p = print
r = range
rp = repr
rvr = reversed
rnd = round
srt = sorted
s = str
sm = sum
t = Screen()
v = vars
w = Turtle()
z = zip
def rf(s): # regex finder
    index = s.index("!")
    regex = re.compile(s[:index])
    search = s[index + 1 :]
    if search[0] == "!":
        return regex.findall(search[1:])
    else:
        return regex.findall(eval(search))
q = chr(34)
k = "\n"

def e(s):
    raise RuntimeError(s)
j = input("Enter image file ")
i = Image.open(j)
t.setup(width=i.width, height=i.height, startx=0, starty=0)
t.bgpic(picname=j)
x1=int(input("x1 "))
y1=int(input("y1 "))
x2=int(input("x2 "))
y2=int(input("y2 "))
c=input("c ")
w.pc(c)
w.pu()
playsound("sound.mp3")
w.goto(x1,y1)
w.pd()
w.goto(x2,y2)
playsound("sound.mp3")
done()

