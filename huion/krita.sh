#!/bin/bash

# huion h1161 buttons
# top to bottom: 1 2 3 8 9 | 10 11 12 13 14

#           Tab - toggle canvas mode
#             2 - zoom to page fit
#             3 - zoom to page width
#  Ctrl Shift A - deselect
#        Ctrl R - rectangle select tool
#             T - move tool
#             B - brush tool
#             E - eraser mode
#        Ctrl Z - undo
#  Ctrl Shift Z - redo
#             5 - reset rotation
# +shift +space - rotate (hold and drag stylus)
#          Ctrl - color picker
#             ] - increase brush size
#             [ - decrease brush size
#        Ctrl 0 - 100% pixel size

xsetwacom set "HUION Huion Tablet Pad pad" button 1  key ctrl 0
xsetwacom set "HUION Huion Tablet Pad pad" button 2  key 2 5
xsetwacom set "HUION Huion Tablet Pad pad" button 3  key e
xsetwacom set "HUION Huion Tablet Pad pad" button 8  key b
xsetwacom set "HUION Huion Tablet Pad pad" button 9  key +ctrl
xsetwacom set "HUION Huion Tablet Pad pad" button 10 key +shift
xsetwacom set "HUION Huion Tablet Pad pad" button 11 key ctrl r
xsetwacom set "HUION Huion Tablet Pad pad" button 12 key t
xsetwacom set "HUION Huion Tablet Pad pad" button 13 key ctrl shift a
xsetwacom set "HUION Huion Tablet Pad pad" button 14 key ctrl z

xsetwacom --set "HUION Huion Tablet Pen stylus" suppress 30
