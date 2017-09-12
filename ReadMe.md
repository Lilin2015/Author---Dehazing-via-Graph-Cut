This is the demo of the manuscipt "Dehazing via Graph Cut".
It have some detail problems, but the main ideas of the proposed method are exactly implemented.
*************************************************************
"opencv_world300.dll" is needed. It is included in the file.
However, if any problem happens on mex file, you can compile the mex by yourself with the
source code in 'Appendix.zip'.
*************************************************************
Run 'main.m'.
*************************************************************
There are some known problems of the demo:
1) the mexfunction 'GraphCut' might crash after being called multi-times.
   It might has memory leak problem but we don't known the reason yet.
2) if the mexfunction 'GraphCut' keeps crash on a single image,
   try to resize the image.
3) the core code of graph cut is compatible with gray-scale images, 
   but the whole program is still wrote for RGB-image.
   You can achieve it by some simple modification without changing the core code of graph cut.
*************************************************************
Examples:

![image](https://github.com/Lilin2015/Dehazing-via-Graph-Cut/raw/master/display/display.png)