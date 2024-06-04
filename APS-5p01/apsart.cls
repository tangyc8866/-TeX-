% !Mode:: "TeX:UTF-8"
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    《应用概率统计》论文TeX模板文档类 apsart.cls
%%     This the class file of the apsart class with LaTeX2e.
%%     Copyright 2006-2024
%%
%%     Ver 5.01 By 汤银才, yctang@stat.ecnu.edu.cn
%%                 
%%
%%  版本历史:
%%        Ver0.01   2005.09.10
%%        Ver1.01   2006.03.01
%%               1. 更改编号出现错位
%%               2. 增加作者信息
%%               3. 调整首页标题、作者和摘要之间的间距
%%        Ver1.02   2007.10.01
%%               1. 将作者信集中处理
%%               2. 将设置文件更改为APSart.cls，
%%                  中英文论文按采用选项Chniese/English
%%        Ver2.0    2012.10.10											
%%                  扩展了Windows下使用CTEX套装的编译方法					
%%                    - pdfLaTeX
%%                    - LaTeX + dvi2pdf
%%                    - XeLaTeX 						
%%         Ver3.0   2014.10.10											
%%                  统一不同操作系统的编码与编译方式
%%                    - 采用UTF-8编码			
%%                    - 采用XeLaTeX编译		
%%         Ver4.0   2015.3.28
%%                  修改定理等字体及编码方式		
%%                    - 采用UTF-8编码					
%%                    - 采用XeLaTeX编译(Windows, Mac OSX)
%%                    - 采用pdfLaTeX编译(Windows)
%%         Ver5.0   2024.4.18
%%                  修改定理等字体及编码方式		
%%                    - 修改期刊页面设置					
%%                    - 统一采用XeLaTeX编译
%%                    - 用biber/bilatex管理文献目录与引用
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{APSart}[2024/04/18 v5.01 APSart document class]
\DeclareOption{Chinese}{%
  \AtBeginDocument{\input{APSart_cn.cfg}}%
  \PassOptionsToClass{\CurrentOption}%
    {ctexart}}
\DeclareOption{English}{%
  \AtBeginDocument{\input{APSart_en.cfg}}%
  \PassOptionsToClass{\CurrentOption}%
    {ctexart}}
\ProcessOptions
\LoadClass[a4paper, 
		   zihao = 5, 11pt,
		   onecolumn, twoside, 
		   UTF8]{ctexart}[2004/08/14]

%--------------------------------%
%         基本的宏包		         %
%--------------------------------%
%% 超链接: pdf论文中引用产生 (网络版)   
\RequirePackage{hyperref}
\hypersetup{%
	    unicode={true},% 使用 unicode 来编码 PDF 字符串
  		pdfstartview={FitH},% 文档初始视图为匹配宽度
  		bookmarksnumbered={true},% 书签附上章节编号
  		bookmarksopen={true},% 展开书签
  		pdfborder={0 0 0},% 链接无框
  		citecolor=black, % blue
  		linkcolor=black, % blue
  		anchorcolor=blue,
  		urlcolor=blue,
  		colorlinks=true,     %注释掉此项则交叉引用为彩色边框(将colorlinks和pdfborder同时注释掉)
  		pdfborder=000        %注释掉此项则交叉引用为彩色边框
  		pdfstartview=FitH,
  		pdfpagemode=FullScreen % 实现打开后全屏
		}

%% 数学类宏包
\RequirePackage{amsmath,amssymb,amsfonts,amsthm,mathrsfs}
\RequirePackage{booktabs}   % 三线表
\RequirePackage{color}      % 颜色
\RequirePackage{fancyhdr}   % 页眉设置
\RequirePackage{fancyvrb}   % 抄录环境
\RequirePackage{graphicx}   % 图形宏包
\RequirePackage{upgreek}    % 希腊字母斜体转正体


%--------------------------------%
%         特定宏包	  	          %
%--------------------------------%
\RequirePackage{subcaption}      % 子图subfigure 
% 图表(子图)中caption设定
\RequirePackage{multirow}        % 多行表格, \multirow类似于\multicolumn
\RequirePackage[margin=2em,
				labelsep=space,
				skip=0.5em]{caption}  %,font=small
\RequirePackage{float}          % 允许图表使用 [H] 选项

%\RequirePackage[mathlines,sep=11pt,width=11pt]{lineno}
%\RequirePackage[mathlines]{lineno} %% <- remove [mathlines] to omit equation line numbers
\RequirePackage{lineno}
\RequirePackage{amsmath}  % after lineno
\RequirePackage{etoolbox}  % <- for \pretocmd, \apptocmd and \patchcmd

% 调整列表环境的间距和标签式样
\RequirePackage{enumitem} % 垂直间距参数: topsep, parset, itemsep, partopsep
                          % 水平间距参数: leftmargin, rightmargin, labelsep, itemindent, labelwidth, listparindent
                          % 标签: label= (\arabic*), \emph{\alph*}, (\Roman*)

% 文献管理工具，基于bib库用biber替代bibtex
\RequirePackage[
			backend=biber, %biber
			style=gb7714-2015,
%			style=gb7714-2015ms, 
			]{biblatex}
%%\RequirePackage{cite} % 不能与bilatex 同时使用


%--------------------------------%
%         页面全局设置             %
%--------------------------------%

\RequirePackage[textwidth = 15cm,    % 正文的宽度
				textheight = 21.5cm, % 正文的高度
				headheight = 11pt,   % 页眉的高度 
				headsep = 6mm,       % 正文与页眉的空隙 
				footskip = 0pt,      % 正文与页脚的空隙
				includehead = true,  % total body 包括页眉
				includefoot = true,  % total body 包括页脚
				bindingoffset = 0pt  % 装订偏移量
%				marginratio={1:1, 2:3}
				]{geometry}            

%% 附录(appendix）设置
%% 设置一些预备代码，仅在\appendix之后才激活
%% 详见 'The LaTeX Companion,' 2nd. ed., pp. 26f.
\makeatletter
\def\@seccntformat#1{\@ifundefined{#1@cntformat}%
	{\csname the#1\endcsname\quad}    %      default
	{\csname #1@cntformat\endcsname}  %      enable individual control
}
\makeatother


\parindent 2\ccwd
\renewcommand{\baselinestretch}{1.2}
%% 修改论文标题的前置空行数
\makeatletter
\def\@maketitle{%
 \newpage
  \null
  \vskip 0em%  
 \begin{center}%
 \let \footnote \thanks
   {\LARGE \@title \par}%
   \vskip 1.5em%
   {\large
     \lineskip .5em%
     \begin{tabular}[t]{c}%
       \@author
     \end{tabular}\par}%
   \vskip 1em%
   {\large \@date}%
 \end{center}%
 \par
 \vskip 1.5em}
\makeatother
\endinput

%%
%% End of file `APSart.cls'.
