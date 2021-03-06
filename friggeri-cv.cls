\ProvidesClass{friggeri-cv}[2012/04/30 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}


%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX,vargreek-shape=unicode]{unicode-math}

\newfontfamily\bodyfont
[BoldFont=texgyreheros-bold.otf,
ItalicFont=texgyreheros-italic.otf,
BoldItalicFont=texgyreheros-bolditalic.otf]
{texgyreheros-regular.otf}
\newfontfamily\thinfont[]{Lato-Light.ttf}
\newfontfamily\headingfont[]{texgyreheros-bold.otf}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont
[Mapping=tex-text, Color=textcolor,
BoldFont=texgyreheros-bold.otf,
ItalicFont=texgyreheros-italic.otf,
BoldItalicFont=texgyreheros-bolditalic.otf
]
{texgyreheros-regular.otf}

\setmathfont{texgyreheros-regular.otf}

\RequirePackage{enumerate}
\RequirePackage{xparse}
\NewDocumentCommand\genlist{>{\SplitList{;}}m}
  {
    \begin{itemize}
      \ProcessList{#1}{ \insertitem }
    \end{itemize}
  }
\newcommand\insertitem[1]{\item[\bullet] #1}

%%%

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}

\newcommand{\rolefont}{%
  \fontsize{18pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
      \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=.4cm] (line) at (current page.north){};
    \node [rectangle, , anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{32pt}{64pt}\color{black}%
      {\thinfont #1} {\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{gray}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        red\or%
        green\or%
        purple\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{.75\parskip}
  {%
    \LARGE\headingfont\color{headercolor} #1%
   % \@sectioncolor #1%
  }
  \par\vspace{.75\parskip}
}

\renewcommand{\subsection}[1]{
  \par\vspace{.5\parskip}%
  {%
  \large\headingfont\color{headercolor} #1%
  }
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\expentry}[5]{%
  \parbox[t]{14cm}{%
    \textbf{#1}%
    \hfill%
    {\footnotesize\addfontfeature{Color=gray} #2}\\%
    \emph{#3}
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #4}
    \genlist{#5}
    \vspace{\parsep}\\%
    
  }\\}
  
  \newcommand{\eduentry}[6]{%
    \parbox[t]{14cm}{%
        \textbf{#1}%
        \hfill%
        {\footnotesize\addfontfeature{Color=gray} #2}\\%
        #4
        \hfill%
        {\footnotesize\addfontfeature{Color=lightgray} #3}\\\\%
        #5
        \\\\
        #6
    \vspace{\parsep}%
    
  }\\}


%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{4.7}(0.8, 3.4)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}


%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=6.1cm,top=1.2cm,right=1cm,bottom=0.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}