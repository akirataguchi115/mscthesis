%%
%% This is file `HYthesisML.cls'
%%
%% 
%% HYthesisML.cls supports the creation of BSc and MSc theses,
%% seminar papers, and other reports at the Department of Computer Science at the University of Helsinki. An eventual motivation
%% is to spread the style to uses at other departments as well, by
%% making localisations easy. 
%%
%%% This work may be distributed and/or modified under the
  % conditions of the LaTeX Project Public License, either version 1.3
  % of this license or (at your option) any later version.
  % The latest version of this license is in
  %   http://www.latex-project.org/lppl.txt
  % and version 1.3 or later is part of all distributions of LaTeX
  % version 2005/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[2000/06/01]
\ProvidesClass{HYthesisML}[2018/10/01 v1.0 Document class for BSc and MSc theses in Computer Sciences of University of Helsinki]
%
\newif\if@finnish%
\newif\if@swedish%
\newif\if@english%
\@finnishfalse\@swedishfalse\@englishfalse%
\newif\if@latin\@latinfalse%
% computer science specific content starts
\newif\if@cs% 
\newif\if@csm%
\newif\if@tkt%
\newif\if@tktl%
\newif\if@dsm%
\newif\if@censored%
\newif\if@seminar%
\@csfalse\@csmfalse\@tktfalse%
\@tktlfalse\@dsmfalse\@censoredfalse%
\@seminarfalse%
% computer science specific content ends
%
\DeclareOption{finnish}{\@finnishtrue}
\DeclareOption{swedish}{\@swedishtrue}
\DeclareOption{english}{\@englishtrue}
                                          % requires extra user commds
\DeclareOption{latin}{\@latintrue}        % Latin0 vs utf8

% line content starts
\DeclareOption{sw-line}{\def\track{sw-line}}
\DeclareOption{alko-line}{\def\track{alko-line}}
\DeclareOption{nodes-line}{\def\track{nodes-line}}
\DeclareOption{bio-line}{\def\track{bio-line}}
%- should some of these be removed? TM2021
% \DeclareOption{sw-line-2017}{\def\track{sw-line-2017}}
% \DeclareOption{alko-line-2017}{\def\track{alko-line-2017}}
% \DeclareOption{nodes-line-2017}{\def\track{nodes-line-2017}}
% \DeclareOption{bio-line-2017}{\def\track{bio-line-2017}}
% \DeclareOption{sw-track-2018}{\def\track{sw-track-2018}}
% \DeclareOption{alko-track-2018}{\def\track{alko-track-2018}}
% \DeclareOption{nodes-track-2018}{\def\track{nodes-track-2018}}
\DeclareOption{software-track-2020}{\def\track{software-track-2020}}
\DeclareOption{algorithms-track-2020}{\def\track{algorithms-track-2020}}
\DeclareOption{networking-track-2020}{\def\track{networking-track-2020}}

% line content ends

% programme specific content starts
\DeclareOption{cs}{\@cstrue}
\DeclareOption{csm}{\@csmtrue}
\DeclareOption{tkt}{\@tkttrue}
\DeclareOption{tktl}{\@tktltrue}
\DeclareOption{dsm}{\@dsmtrue}
\DeclareOption{censored}{\@censoredtrue}
\DeclareOption{seminar}{\@seminartrue}
% programme specific content ends

\newif\if@oneside
\newif\if@twoside
\@onesidefalse
\@twosidetrue
\newif\if@defaulttypesize
\@defaulttypesizetrue

\DeclareOption{oneside}{\@onesidetrue\@twosidefalse}
\DeclareOption{twoside}{\@twosidetrue\@onesidefalse}
\DeclareOption{10pt}{
  \@defaulttypesizefalse
  \PassOptionsToClass{10pt}{report}}
\DeclareOption{11pt}{
  \@defaulttypesizefalse
  \PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{
  \@defaulttypesizefalse
  \PassOptionsToClass{12pt}{report}}
\DeclareOption{a4paper}{
  \PassOptionsToClass{a4paper}{report}}
\if@defaulttypesize
  \PassOptionsToClass{12pt}{report}
\fi

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
% Report class takes care of any errors in options.
\ProcessOptions\relax

\LoadClass{report}[2000/05/19]

\RequirePackage[T1]{fontenc}

\RequirePackage{latexsym}[1998/08/17 v2.2e Standard LaTeX package (lasy symbols)]

\if@latin
\RequirePackage[latin9]{inputenc}[2015/03/17 v1.2c The inputenc package]
\else
\RequirePackage[utf8]{inputenc}[2015/03/17 v1.2c v1.3 The inputenc package]
\fi


\if@finnish
  \RequirePackage[english,swedish,main=finnish]{babel}[2001/03/01 v3.7h The Babel package]
  \selectlanguage{finnish}
  %\selectbiblanguage{finnish}
\else
  \if@english
    \RequirePackage[swedish,finnish,main=english]{babel}[2001/03/01 v3.7h The Babel package]
    \selectlanguage{english}
    %\setbiblanguage{english} 
   \else
    \if@swedish
      \RequirePackage[finnish,english,main=swedish]{babel}[2001/03/01 v3.7h The Babel package]
      \selectlanguage{swedish}
      %\setbiblanguage{swedish}
    \fi
  \fi
% viimeinen osa pois
\fi

%\RequirePackage{geometry}
%\if@oneside
%    \geometry{oneside,vscale=0.8, includefoot, vmarginratio={1:1}, hmarginratio={3:2}}
%\else
%    \geometry{twoside,vscale=0.8, includefoot, vmarginratio={1:1}, hmarginratio={3:2}}
%\fi
%\savegeometry{defaultgeometry}

\RequirePackage{geometry}[1999/10/07 v2.2 Page Geometry]
%TM: changed the geometry to the same as Data Science template
% \newcommand{\defaultsettings}{%
%   \if@twoside
%     \geometry{top=2.5cm, left=2.8cm, right=3.2cm,
%               textwidth=15cm, textheight=23cm,
%               headheight=0.5cm, headsep=0.5cm}%
%   \else
%     \geometry{top=2.5cm, left=3.5cm, right=2.5cm,
%               textwidth=15cm, textheight=23cm,
%               headheight=0.5cm, headsep=0.5cm}%
%   \fi
% }
\newcommand{\defaultsettings}{%
  \if@twoside
    \geometry{bindingoffset=0.5cm,top=2.5cm, left=2.5cm, right=2.5cm,
              %TM- removed, overspecification
              %textwidth=16cm, 
              textheight=23cm,
              headheight=0.5cm, headsep=0.5cm}%
  \else
    \geometry{top=2.5cm, left=2.5cm, right=2.5cm,
              textwidth=16cm, textheight=24cm,
              headheight=0.5cm, headsep=0.5cm}%
  \fi
}
%TM: added the following as the use of the just defined macro was missing
\defaultsettings

% Default marginratio is 1:1 for oneside 2:3 for twoside pages
% Default vscale=0.7, hscale=0.7
% Bindingoffset would increase the smaller margin (inner) and decrease the textwidth,
% therefore, same bindingoffset effect is here obtained by swapping the margin 
% Better fill rate for Finnish and more appropriate footnote management acquired by
% balancing hscale+includefoot options

                          % This is necessary: utilised (as 
                          % replacementof obsolete packages)
\RequirePackage{etoolbox} % for careful patching of internal macros
                          % if constructs
                          % hooks for \atbegindocument, \atenddocument 
\patchcmd{\chapter}{plain}{empty}{}{}
                          % removes page numbers from p1 of chapter
\RequirePackage{lastpage}
\RequirePackage{nomencl}
\RequirePackage{emptypage}
\RequirePackage{perpage}
%
                           % This is the area of expected changes
\RequirePackage{titlesec}  % as new form packages arrive
\RequirePackage{titletoc}
\RequirePackage{titleps}
\RequirePackage[page,toc,title,titletoc,header]{appendix}
\patchcmd{\@chap@pppage}{\thispagestyle{plain}}{\thispagestyle{empty}}{}{}
\RequirePackage[subfigure]{tocloft}
\noappendicestocpagenum
\titleformat{\chapter}[hang]{\Huge\bfseries}{\thechapter}{0.5em}{}
\titlespacing*{\chapter}{0pt}{-20pt}{30pt}


\RequirePackage{xstring}


%%%%  keep these good charm lines! 
\setcounter{page}{1}
\setcounter{chapter}{0}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1ex}
\renewcommand{\normalsize}{\fontsize{12}{15}\selectfont}
\pagenumbering{arabic}
\pagestyle{myheadings}
\setcounter{chapter}{0}
\pagenumbering{roman}
\setcounter{chapter}{0}
% This is a bottleneck: if abstract of report style pushes in
% anything extra, the output document and error messages
% get garbled and uninterpretable. There is a simple abstract
% text page (centered) left, but all document control structures 
% are lost.
\RequirePackage[runin]{abstract}[2001/06/11]
\renewcommand{\abstractname}{}    % clear the title
\renewcommand{\absnamepos}{empty} % originally center
\renewcommand{\@bsrunintitle}{}
%%%%  end of charm

% Computer science: use 1-1.5 as a normal for 1-column documents.
\newcommand{\onehalfspacing}{%
  \ifcase\@ptsize\relax % 10pt
    \renewcommand{\baselinestretch}{1.25}%
  \or % 11pt
    \renewcommand{\baselinestretch}{1.213}%
  \or % 12pt
    \renewcommand{\baselinestretch}{1.241}%
  \fi
  \normalsize
}
\newcommand{\doublespacing}{
  \ifcase\@ptsize\relax % 10pt
    \renewcommand{\baselinestretch}{1.667}
  \or % 11pt
    \renewcommand{\baselinestretch}{1.618}
  \or % 12pt
    \renewcommand{\baselinestretch}{1.655}
  \fi
  \normalsize
}
\newcommand{\singlespacing}{%
  \renewcommand{\baselinestretch}{1.0}%
  \normalsize
}

\newcommand{\mytableofcontents}{%
% next page with text should be odd
%TM:  \newpage
  \cleardoublepage
 
  \tableofcontents
%TM:  \newpage
  \cleardoublepage
  \pagenumbering{arabic}
%  \if@emptyfirstpagenumber
    \thispagestyle{empty}
%  \fi
}

%%%% trilanguage handling
\RequirePackage{translator}  % see the 3 files of translator-UHCSthesis
\usedictionary{template/translator-UHCSthesis-coverpage-dictionary}

%%%%%% Define commands for filling abstract
%%%%% For form texts
\newcommand{\oppiaine}[1]{\gdef\@oppiaine{#1}} % abstract template
%%%%% Degree elements
%Defined elsewhere --report
%\newcommand{\author}[1]{\gdef\@author{#1}}
%\newcommand{\title}[1]{\gdef\@title{#1}}

\newcommand{\warnText}[1]{
{\color{red}{#1}}
}


%These determined through options or commands
%\newcommand{\level}[1]{\gdef\@level{#1}}
%\newcommand{\programme}[1]{\gdef\@programme{#1}}
%\newcommand{\subject}[1]{\gdef\subject{#1}}
%\subject{}
\newcommand{\subject}{}
\newcommand{\getSubject}{
    \department
}

\newcommand{\seminar}[1]{\gdef\@seminar{#1}}
%%%%% Document details
\newcommand{\depositeplace}{\translate{library}}
\newcommand{\pp}{\translate{pp}}
\newcommand{\app}{\translate{appendices}}
\newcommand{\appno}{\translate{appendice pages}}
\newcommand{\ccs}[1]{\gdef\@ccs{#1}}
\ccs{ACM Computing Classification System (CCS)}
% From document itself
\newcommand{\classification}[1]{\gdef\@classification{#1}}
\classification{\space Compulsory ACM classification missing}
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\keywords{}
\newcommand{\additionalinformation}[1]{\gdef\@additionalinformation{#1}}
%\additionalinformation{}
%%%%% Evaluation related elements
\newcommand{\supervisorslabel}{\translate{supervisors}}
\newcommand{\examinerlabel}{\translate{examiner}}
% From document
\newcommand{\supervisors}[1]{\gdef\@supervisors{#1}}
\newcommand{\examiners}[1]{\gdef\@examiners{#1}}

%%%%% Organisation elements
\newcommand{\uh}{\translate{uh}}
\newcommand{\address}{\translate{address}}
\newcommand{\eaddress}{\translate{eaddress}}
\newcommand{\ytiedot}{\translate{ytiedot}}
\newcommand{\helsinki}{\translate{helsinki}}
\newcommand{\faculty}{\translate{faculty}}

%%% Process degree specific info

\if@tkt
    \newcommand{\level}%
      {\translate{tkt-bsc-level}}
    \newcommand{\programme}%
      {\translate{tkt-programme}}
    \newcommand{\department}%
      {\translate{department2018}}
    \renewcommand{\oppiaine}{{Koulutusohjelma --- Utbildningsprogram  --- Study programme}}
    \renewcommand{\getSubject}{\programme}
    \providecommand{\track}{}
\fi
\if@tktl
    \newcommand{\level}%
      {\translate{tkt-bsc-level}}
    \newcommand{\programme}%
      {\translate{tktl-programme}}
    \newcommand{\department}%
      {\translate{department2017}}
    % expected document to set \subject{}
    \renewcommand{\oppiaine}%
       {{Koulutusohjelma --- Utbildningsprogram  --- Study programme}}
    % VM: poistin "oppiaineeseen laitos" lisäämällä allaolevan
    \renewcommand{\department}{\programme}
    \renewcommand{\getSubject}{\programme}
    \providecommand{\track}{}
\fi
\if@cs
    \renewcommand\subject{\translate{\track}}
    \newcommand{\level}{\translate{msc-level-2018}}
    \newcommand{\programme}{\translate{cs-programme}}
    \newcommand{\department}{\translate{department2017}}
    \renewcommand{\oppiaine}{{Koulutusohjelma --- Utbildningsprogram  --- Study programme}}
    % VM: poistin "oppiaineeseen laitos" lisäämällä allaolevan
    \renewcommand{\department}{\programme}
    %\renewcommand{\getSubject}{\programme}
    %VM: adding stydy line / study track to additional information
    %\renewcommand{\additionalinformation}{\subject}
%    \renewcommand{\getSubject}{
%        \ifx\subject\empty
%            \warnText{!! You must set subject !!}
%        \else
%            \department:\\ \subject
%        \fi
%    }
\fi
\if@csm
    \renewcommand\subject{\translate{\track}}
    \newcommand{\level}{\translate{msc-level-2020}}
    \newcommand{\programme}{\translate{csm-programme}}
    \newcommand{\department}{\translate{department2018}}
%    expected document to set \subject{}
     \renewcommand{\oppiaine}{{Koulutusohjelma --- Utbildningsprogram  --- Study programme}}
     \renewcommand{\department}{\programme}
    %VM: adding stydy line / study track to additional information
    %\renewcommand\additionalinformation{\subject}
    %TM: commented out -- no more study lines printed
    % \renewcommand{\getSubject}{
    %     \ifx\subject\empty
    %         \warnText{!! You must set subject !!}
    %     \else
    %         \department:\\ \subject
    %     \fi
    % }
\fi
\if@seminar
    \newcommand{\level}{\translate{seminar}}
    \newcommand{\programme}{}
    \renewcommand{\getSubject}{\programme}
    \renewcommand{\oppiaine}{{Koulutusohjelma --- Utbildningsprogram  --- Study programme}}
\fi

%% actual parameters from document

%% Look of the reports
\usepackage{lmodern} 
\usepackage{textcomp} 
\usepackage[pdftex]{color, graphicx} % For pdf output and jpg/png graphics
\usepackage{epsfig}
\usepackage{subfigure} 
\usepackage{tikz}            % For making vector graphics (hard to learn but powerful)
\usepackage{amsmath, amssymb} % For better math
\usepackage[footnotesize,bf]{caption}  % For more control over figure captions
\usepackage{blindtext}
\usepackage{everyshi}

\newtoggle{mainmatter}
\newtoggle{backmatter}
\togglefalse{mainmatter}
\togglefalse{backmatter}

\newcommand{\frontmatter}{
    \setcounter{page}{1}
    \pagenumbering{arabic}
}


\newcommand{\mainmatter}{
    \toggletrue{mainmatter}
    \thispagestyle{empty}
    \pagenumbering{arabic}
    \setcounter{page}{1}
}

\newcommand{\backmatter}{%
    \clearpage % needed so that mainmatter is fully flushed before turning off the counter
    \togglefalse{mainmatter}
    
    \addtocontents{toc}{\cftpagenumbersoff{chapter}}
    \cleardoublepage
    \toggletrue{backmatter}

    \titleformat{\chapter}{\large\bfseries}{\chaptertitlename\space\thechapter\newline}{0.5em}{\setcounter{page}{1}\pagenumbering{roman}\markboth{\chaptertitlename\space\thechapter}{\chaptertitlename \space\thechapter}\label{Appendix.\thechapter}\thispagestyle{empty}}
%    \titleformat{\chapter}{\Huge\bfseries}{\chaptertitlename\space\thechapter\newline}{0.5em}{\setcounter{page}{1}\pagenumbering{arabic}\markboth{}{}\label{Appendix.\thechapter}}
    \thispagestyle{empty}
}

\EveryShipout{%
    \iftoggle{mainmatter}{\stepcounter{numberofpages}}{}%
    \iftoggle{backmatter}{\stepcounter{numberofappendixpages}{}}
}



% Additions and changes for document key terms. 
% These address elements required for computer science.
\addto\captionsenglish{%
\renewcommand{\bibname}{References}%
\renewcommand{\refname}{References}%
\renewcommand{\nomname}{List of acronyms}%
}
\addto\captionsfinnish{%
\renewcommand{\bibname}{L\"ahteet}%
\renewcommand{\refname}{L\"ahteet}%
\renewcommand{\appendixname}{Liite}%
\renewcommand{\appendixpagename}{Liitteet}%
\renewcommand{\appendixtocname}{Liitteet}%
%\renewcommand{\appendicestocname}{Liitteet}%
%\renewcommand{\appendicespagename}{Liitteet}%
\renewcommand{\enclname}{Liite}%
\renewcommand{\nomname}{Lyhenteet}%
%\renewcommand{\enclpagename}{Liite}%
%\renewcommand{\encltocname}{Liite}%
}
\addto\captionsswedish{%
\renewcommand{\bibname}{Referenser}%
\renewcommand{\refname}{Referenser}%
\renewcommand{\appendixname}{Bilaga}%
\renewcommand{\appendixtocname}{Bilagor}%
\renewcommand{\appendixpagename}{Bilagor}%
%\renewcommand{\appendicespagename}{Bilagor}%
%\renewcommand{\appendicestocname}{Bilagor}%
\renewcommand{\enclname}{Bilaga}%
\renewcommand{\nomname}{List av akronymer}%
}
\def\dateswedish{\def\today{\number\day.\number\month.\number\year}}
\def\datefinnish{%
  \def\today{\number\day.\number\month.\number\year}}
\def\division{\char'057}

%--------------------------------------------------------------------------
% Nomenclature: titles and unit space
%\makenomenclature
%\newcommand{\nomunit}[1]{%
%\renewcommand{\nomentryend}{\hspace*{\fill}#1}}

%\newcommand{\mynomenclature}{%
%\ifnum0\pdffilesize{\jobname.nls}>0
%	\printnomenclature
%	\addcontentsline{toc}{chapter}{\nomname}
%	\markboth{\nomname}{}
%	\cleardoublepage
%\fi
%\pagenumbering{arabic}
%}


\renewcommand*{\thefootnote}{\fnsymbol{footnote}} %footnote symbols for one page only
\MakePerPage{footnote}

%%%%%% Appendices %%%%%%%

\newcounter{appendixPagesCounter}
\setcounter{appendixPagesCounter}{0}%

\let\oldappendix\appendix
\renewcommand{\appendix}[1]{
%TM: This one set the last page of each appendix to 1, which kinda is not what one wants 
%TM:-        \setcounter{page}{1}%
    \chapter{#1}
}


\renewcommand{\appendices}{%
    %\setcounter{page}{-1}%
%  \setcounter{appendix}{1}%
%  \newpage
%  %\pagestyle{empty}
%  \pagestyle{myheadings}
%  \markright{}
    \oldappendix
%  \addtocontents{toc}{\protect \contentsline {section}{\enclname}{}}
%  \setcounter{page}{0}
}


\AtEndPreamble{
   % Biblatex doesn't use bibname or refname. Instead it overwrites it with its own value.
   % These values must be fixed manually, and done after biblatex has been loaded.
   \@ifpackageloaded{biblatex}{
       \DefineBibliographyStrings{finnish}{%
          bibliography = {L\"ahteet}
       }
       \DefineBibliographyStrings{swedish}{%
          editor       = {red.},
          editors      = {red.},
          bibliography = {Referenser}
       }
   }

}

\AtBeginDocument{
    \newcounter{numberofpages}
    \newcounter{numberofappendixpages}

    \setcounter{numberofpages}{0}
    \setcounter{numberofappendixpages}{0}
}



\AtEndDocument{%
    \typeout{***AED Number of Appendices \thenumberofappendixpages}
    \immediate\write\@auxout{\string\gdef\string\appendixCount{\thenumberofappendixpages}}

    \typeout{***AED Number of pages \thenumberofpages \pp}
    \immediate\write\@auxout{\string\gdef\string\pagesCount{\thenumberofpages}}
}



\newcommand{\getPageInfo}{%
    \@ifundefined{pagesCount} {
        \warnText{!! Run three times to appear !!}
     } {
        \ifnumcomp{\appendixCount}{>}{0}{%
            \pagesCount\space\pp,\space\appendixCount\space\appno
        }{
            \pagesCount\space\pp
        }
    }
}


%---------------------------------------------

% GENERATE TITLE PAGE

%%%%%%%%%%%%%%      Cover pages
%% define first the inside of cover page, i.e. the second page
\newcommand{\innerpage}{%
\makeatletter
\setcounter{page}{-998}
\label{in}
\thispagestyle{empty}
% \if@censored 
%  {
%     \par
%     {\bf\supervisorslabel}\par
% %TM: parindent only indents the first line -> use \leftskip within {}
% %    {\addtolength{\parindent}{2em} 
%     {\leftskip=2em
%      \@supervisors
%   %  \addtolength{\parindent}{-2em}}
%      \par
%     }
    
%     \par
%     {\bf\examinerlabel}\par
%     {\leftskip=2em
%      \@examiners
%      \par
%     }
% }
% \fi

\vspace{4.0cm}
    \par
    {\bf \ytiedot}\par
    \hfill\par
    %TM: Using \leftskip here, too. Removed \indent from translation files after \newline
    {\leftskip=2em
     \address
     \par
    }
    \hfill\par
    {\leftskip=2em
     \eaddress
     \par
    }
%TM: 
\vfill

%TM: commented out as it seems \makeatother should not used in .cls files...
%\makeatother
\thispagestyle{empty}
} 

%%%% actual cover page, triggers the backside of the leaf printed too

\renewcommand{\maketitle}{%
%TM: removed, as seems not needed !?
%\enlargethispage{0.7in}
\hypersetup{pageanchor=true}
\setcounter{page}{-999}
\label{title}
%\if@seminar
% \level{}
%\fi


\onehalfspacing

\begin{center}
\includegraphics[width=5cm]{template/figures/HY-logo-ml.png}

%\makeatletter
\begin{large}
\level

\programme

% VM: Removed study line = study track from title page
%\if@csm
    %TM- skip subject (=study line) 
%\else
%    {\subject}
%\fi

\end{large}

\vspace{1.7cm}

\begin{LARGE}
{\bf \@title}
\end{LARGE} 

\vspace{2cm}

\begin{large}
\@author
\end{large}

\vspace{14pt}

\begin{large}
\today

\vspace{2.5cm}
%{\bf \@seminar}

\vspace*{\fill}

{\rm\sc
    \faculty

    \uh
}
\end{large}
%\makeatother
\end{center}

\thispagestyle{empty}\newpage
\innerpage
}


%------------------------------------------------------------------------

\newsavebox{\@abstract}

%TM: modified to make abstract bit tightier
\newenvironment{@summary}{
    \abst@small %TM:+
    \begin{lrbox}{\@abstract}
    \begin{minipage}[t][12cm]{5.7in} %TM: fixed the minipage height (=summary+ACM classif to 12cm); adjust if layout changes
    \setlength{\parskip}{2ex}
}
{ 
    \vfill %TM: works only here, if the minipage height is known, thus fixed above
    {\bf \@ccs}
    %TM:- \par\space\par
    \abst@small \@classification
    \end{minipage}
    \end{lrbox}
%TM this needed moving after changes to abstract page 
%    \put(75, 560){\mbox{\usebox{\@abstract}}}
    \put(22, 450){\mbox{\usebox{\@abstract}}}

%TM just used for debugging:
%    \put(75, 560){\framebox{\usebox{\@abstract}}}
}

\def\abst@small{\fontsize{10}{10}\selectfont}
\def\abst@tiny{\fontsize{6}{7}\selectfont}


% Making the boxed abtract page, in all languages used
\renewenvironment{abstract}%
{
\iflanguage{finnish}{\label{page.abstract.finnish}}{\iflanguage{swedish}{\label{page.abstract.swedish}}{\iflanguage{english}{\label{page.abstract.english}}{\label{page.abstract.other}}}}
%TM:- commented following line out due to multiple times defined label warning 
% \label{page.abstract.}
\thispagestyle{empty}\newpage

% would be nice to know how to change the page geometry within these environment so that the picture would fit within the text area -- now only page length can be easily changed, as some other stuff does not have effect at this point. 
% \newgeometry{bindingoffset=0cm, top=0cm, left=0cm, right=0cm, bottom=0cm,
%               %TM- removed, overspecification
%               %textwidth=16cm, 
%               %textheight=29cm,
%               headheight=0cm, headsep=0cm}
%or these            
% \setlength{\topsep}{100pt}%
% \setlength{\leftmargin}{0pt}%
% \setlength{\rightmargin}{0pt}%
%This works in making the page longer
\enlargethispage{24pt} %this is just enough for the current box size

%TM +++ 
\begin{picture}(400,678)(0,0) %pic width is too small to get rid of the overfull hbox warning; just drawing wider; this seems to be no problem for latex page creation, as it only needs to fit the picture as defined, not to care about someone drawing outside the picture.

%Put the content texts there
\put(5, 634){\makebox(200, 8)[l]{\abst@small \faculty}}
\put(233, 634){\makebox(200, 8)[l]{\abst@small \getSubject}}  

\put(5,  601){\makebox(100, 8)[l]{\abst@small \@author}}
\put(5,  564)%
    {\parbox{450pt}{\abst@small \@title}}
 
\put(5,  527)%
    {\parbox{450pt}{\abst@small \@supervisors}}
 
\put(5, 490){\makebox(100, 8)[l]{\abst@small \level}}
\put(160, 490){\makebox(100, 8)[l]{\abst@small \today}}
\put(301, 490){\makebox(100, 8)[l]{\abst@small \getPageInfo}}

\put(5, 85) {\makebox(100, 8)[l]{\abst@small \@keywords}}
\put(5, 55) {\makebox(100, 8)[l]{\abst@small \depositeplace}}
\put(5, 25) {\makebox(100, 8)[l]{\abst@small \@additionalinformation}}
\begin{@summary}
 }{
\end{@summary}

%the bix surrounding box
\put(0,0){\framebox(462,666){}}

%the text on top, outside the big box
\put(1,670){\makebox(461,10)[l]{\abst@small\sc HELSINGIN YLIOPISTO -- HELSINGFORS UNIVERSITET -- UNIVERSITY OF HELSINKI}}

%then the heading texts for the small boxes and lines 
\put(5,657){\makebox(150,6)[l]{\abst@tiny Tiedekunta --- Fakultet --- Faculty}}
\put(231,629){\line(0,1){37}} % pystyviiva
\put(236,657){\makebox(100,5)[l]{\abst@tiny \oppiaine}}
\put(0,629){\line(1,0){462}} 

\put(5,620){\makebox(100,5)[l]{\abst@tiny Tekij\"a --- F\"orfattare --- Author}}
\put(0,592){\line(1,0){462}}

\put(5,583){\makebox(100,5)[l]{\abst@tiny Ty\"on nimi --- Arbetets titel --- Title}}
\put(0,555){\line(1,0){462}}

\put(5,546){\makebox(100,5)[l]{\abst@tiny Ohjaajat --- Handledare --- Supervisors}}
\put(0,518){\line(1,0){462}}

\put(5,509){\makebox(100,5)[l]{\abst@tiny Ty\"on laji --- Arbetets art --- Level}}
\put(154,481){\line(0,1){37}} % pystyviiva
\put(159,509){\makebox(100,5)[l]{\abst@tiny Aika --- Datum --- Month and year }}
\put(297,481){\line(0,1){37}} % pystyviiva
\put(303,509){\makebox(100,5)[l] {\abst@tiny Sivum\"a\"ar\"a --- Sidoantal ---    Number of pages}}

\put(5,472){\makebox(100,5)[l]{\abst@tiny Tiivistelm\"a --- Referat --- Abstract}}
\put(0,481){\line(1,0){462}}

\put(0,0){\line(1,0){462}}
\put(0,50){\line(1,0){462}}
\put(0,80){\line(1,0){462}}
\put(0,110){\line(1,0){462}}
\put(3,101){\makebox(100,5)[l]{\abst@tiny Avainsanat --- Nyckelord --- Keywords}}
\put(1.5,71){\makebox(100,5)[l]{ \abst@tiny S\"ailytyspaikka --- F\"orvaringsst\"alle --- Where deposited}}
\put(5,41){\makebox(100,5)[l]{\abst@tiny Muita tietoja --- \"ovriga uppgifter --- Additional information}}

\end{picture}

}



% %%% TM: ---- OlD way of making the abstract page.
%>>>
% \renewenvironment{abstract}%
% {
% \iflanguage{finnish}{\label{page.abstract.finnish}}{\iflanguage{swedish}{\label{page.abstract.swedish}}{\iflanguage{english}{\label{page.abstract.english}}{\label{page.abstract.other}}}}
% %TM:- commented following line out due to multiple times defined label warning 
% % \label{page.abstract.}
% \thispagestyle{empty}
% %TM: +++ just for cheking the page print area corners
% %+ \hfill +

% %TM: expect the page to have been changed before 
% %\newpage
% %\clearpage
% %\cleardoublepage

% %TM +++ 
% %\begin{picture}(595,842)(50,-90)% The last two are positioning the abstract on the page; TM: that was the here previously, definging an whole page and a picture with an origin way out of the page. (This is the way it was earlier)
% \begin{picture}(400,650)(53,130) %hack: too small pic size (to avoid overfull hbox), moved up to compensate, sad. And  positioning the abstract on the page to compensate for the bottom left corner coordinates used below!?!?
% %\begin{picture}(462,678)(53,110) % Somehow these values sound like closer to proper pic size, but may need changing page geometry or something to work out well. 
% % The framing box (way below) could be in placed in (0,0), but there is an offset in use, so need to compensate for that above (instead of recalculating and changing all the values below;)
% % \put(0,0){\framebox(461,666){}} %try this to see where it goes;)

% \put(58,  744){\makebox(200, 8)[l]{\abst@small \faculty}}

% %TM: changed use of getSubject to be like the others
% %\put(286, 744){
% %    \ifx\subject\empty
% %        \parbox{450pt}{\abst@small \getSubject}        
% %    \else
% %       \parbox[b]{450pt}{\abst@small \getSubject}
% %    \fi
% %
% \put(286, 744){\makebox(200, 8)[l]{\abst@small \getSubject}}   

% \put(58,  711){\makebox(100, 8)[l]{\abst@small \@author}}
% \put(58,  674)%
%     {\parbox{450pt}{\abst@small \@title}}
 
% \put(58,  637)%
%     {\parbox{450pt}{\abst@small \@supervisors}}
 
% \put(58, 600){\makebox(100, 8)[l]{\abst@small \level}}
% \put(213, 600){\makebox(100, 8)[l]{\abst@small \today}}
% \put(354, 600){\makebox(100, 8)[l]{\abst@small \getPageInfo}}

% \put(58, 195) {\makebox(100, 8)[l]{\abst@small \@keywords}}
% \put(58, 165) {\makebox(100, 8)[l]{\abst@small \depositeplace}}
% \put(58, 135) {\makebox(100, 8)[l]{\abst@small \@additionalinformation}}
% \begin{@summary}
%  }{
% \end{@summary}
% \put(53,110){\framebox(462,666){}} % laatikko





% %\put(54,780){\makebox(100,8)[l]{\abst@small\sc HELSINGIN YLIOPISTO -- HELSINGFORS UNIVERSITET -- UNIVERSITY OF HELSINKI}}
% \put(54,780){\makebox(461,10)[l]{\abst@small\sc HELSINGIN YLIOPISTO -- HELSINGFORS UNIVERSITET -- UNIVERSITY OF HELSINKI}}

% \put(58,767){\makebox(150,6)[l]{\abst@tiny Tiedekunta --- Fakultet --- Faculty}}
% \put(284,739){\line(0,1){37}} % pystyviiva
% \put(289,767){\makebox(100,5)[l]{\abst@tiny \oppiaine}}
% \put(53,739){\line(1,0){462}} 

% \put(58,730){\makebox(100,5)[l]{\abst@tiny Tekij\"a --- F\"orfattare --- Author}}
% \put(53,702){\line(1,0){462}}

% \put(58,693){\makebox(100,5)[l]{\abst@tiny Ty\"on nimi --- Arbetets titel --- Title}}
% \put(53,665){\line(1,0){462}}

% \put(58,656){\makebox(100,5)[l]{\abst@tiny Ohjaajat --- Handledare --- Supervisors}}
% \put(53,628){\line(1,0){462}}

% \put(58,619){\makebox(100,5)[l]{\abst@tiny Ty\"on laji --- Arbetets art --- Level}}
% \put(207,591){\line(0,1){37}} % pystyviiva
% \put(212,619){\makebox(100,5)[l]{\abst@tiny Aika --- Datum --- Month and year }}
% \put(350,591){\line(0,1){37}} % pystyviiva
% \put(356,619){\makebox(100,5)[l] {\abst@tiny Sivum\"a\"ar\"a --- Sidoantal ---    Number of pages}}

% \put(58,582){\makebox(100,5)[l]{\abst@tiny Tiivistelm\"a --- Referat --- Abstract}}
% \put(53,591){\line(1,0){462}}

% \put(53,110){\line(1,0){462}}
% \put(53,160){\line(1,0){462}}
% \put(53,190){\line(1,0){462}}
% \put(53,220){\line(1,0){462}}
% \put(58,211){\makebox(100,5)[l]{\abst@tiny Avainsanat --- Nyckelord --- Keywords}}
% \put(54.5,181){\makebox(100,5)[l]{ \abst@tiny S\"ailytyspaikka --- F\"orvaringsst\"alle --- Where deposited}}
% \put(58,151){\makebox(100,5)[l]{\abst@tiny Muita tietoja --- \"ovriga uppgifter --- Additional information}}

% \end{picture}
% }
%<<<




\endinput
%%
%% End of file
