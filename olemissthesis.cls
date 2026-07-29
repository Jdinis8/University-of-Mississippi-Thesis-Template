%% ============================================================================
%% olemissthesis.cls
%% University of Mississippi dissertation/thesis class
%%
%% Adapted by Caroline LaRoche Turnage-Butterbaugh from the Princeton
%% University thesis class created by Jeffrey Scott Dwoskin.
%%
%% Revised to comply with University of Mississippi Graduate School
%% requirements by Harrison Roth (Summer 2026).
%%
%% Consolidated and updated for the LaTeX 2026 heading-template interface
%% by João D. Álvares (2026).
%% ============================================================================

\NeedsTeXFormat{LaTeX2e}[2026-06-01]
\ProvidesClass{olemissthesis}
  [2026/07/29 v1.1 University of Mississippi thesis class]

% This class uses the heading-template implementation activated by
% \DocumentMetadata. In the main document, place \DocumentMetadata before
% \documentclass.

\IfDocumentMetadataTF{}{%
  \ClassError{olemissthesis}
    {\string\DocumentMetadata must appear before \string\documentclass}
    {Add \string\DocumentMetadata{...} at the very beginning of the main
     document, before \string\documentclass.}%
}

% ============================================================================
% Class options
% ============================================================================

\newif\ifolemiss@lot
\newif\ifolemiss@lof
\newif\ifolemiss@los
\newif\ifolemiss@singlespace

\olemiss@lotfalse
\olemiss@loffalse
\olemiss@losfalse
\olemiss@singlespacefalse

\DeclareOption{lot}{\olemiss@lottrue}
\DeclareOption{lof}{\olemiss@loftrue}
\DeclareOption{los}{\olemiss@lostrue}
\DeclareOption{singlespace}{\olemiss@singlespacetrue}
\DeclareOption{doublespacing}{\olemiss@singlespacefalse}

% Pass all other options to the report class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax
\LoadClass{report}

% ============================================================================
% Required packages
% ============================================================================

\RequirePackage{setspace}
\RequirePackage{indentfirst}
\RequirePackage[margin=1in]{geometry}

% ============================================================================
% General document formatting
% ============================================================================

\AtBeginDocument{%
  \raggedright
  \setlength{\parindent}{0.5in}%
  \setlength{\parskip}{0pt}%
}

% Eliminate widows, orphans, and pages ending with a hyphenated word.
\clubpenalty=10000
\widowpenalty=10000
\brokenpenalty=10000

% ============================================================================
% Page-numbering commands
% ============================================================================

\newcommand*{\frontmatter}{\pagenumbering{roman}}
\newcommand*{\mainmatter}{\pagenumbering{arabic}}
\newcommand*{\backmatter}{\pagenumbering{arabic}}

% ============================================================================
% Spacing commands
% ============================================================================

\ifolemiss@singlespace
  \newcommand*{\bodyspacing}{\singlespacing}
  \newcommand*{\extravspace}[1]{\vspace{#1}}
\else
  \newcommand*{\bodyspacing}{\doublespacing}
  \newcommand*{\extravspace}[1]{}
\fi

% Use manually for long tables.
\newcommand*{\tablespacing}{\singlespacing}

% ============================================================================
% Thesis metadata
% ============================================================================

\newcommand*{\submitted}[1]{\gdef\@submitted{#1}}
\newcommand*{\authorcap}[1]{\gdef\@authorcap{#1}}
\newcommand*{\copyrightyear}[1]{\gdef\@copyrightyear{#1}}
\newcommand*{\department}[1]{\gdef\@dept{#1}}
\newcommand*{\departmentprefix}[1]{\gdef\@deptpref{#1}}

\providecommand*{\@submitted}{}
\providecommand*{\@authorcap}{}
\providecommand*{\@copyrightyear}{}
\providecommand*{\@dept}{Physics and Astronomy}
\providecommand*{\@deptpref}{Department of}

\long\def\abstract#1{\gdef\@abstract{#1}}
\long\def\acknowledgements#1{\gdef\@acknowledgements{#1}}
\long\def\dedication#1{\gdef\@dedication{#1}}
\long\def\vita#1{\gdef\@vita{#1}}

% ============================================================================
% Hyperref helpers
% ============================================================================

\newcommand*{\olemiss@hypersetup}[1]{%
  \ifdefined\hypersetup
    \hypersetup{#1}%
  \fi
}

\newcommand*{\olemiss@phantomsection}{%
  \ifdefined\phantomsection
    \phantomsection
  \fi
}

% ============================================================================
% Front-matter pages
% ============================================================================

\newcommand*{\maketitlepage}{%
  \begingroup
    \thispagestyle{empty}%
    \vspace*{.75in}%

    \begin{center}
      \@title\\
    \end{center}

    \vfill

    \begin{center}
      \singlespacing
      A Dissertation\\
      presented in partial fulfillment of requirements\\
      for the degree of Doctor of Philosophy\\
      in the \@deptpref\ \@dept\\
      The University of Mississippi
    \end{center}

    \vfill

    \begin{center}
      by\\
      \@authorcap\\
      \@submitted
    \end{center}

    \clearpage
  \endgroup
}

\newcommand*{\makecopyrightpage}{%
  \olemiss@hypersetup{pageanchor=false}%
  \thispagestyle{empty}%
  \vspace*{0in}%
  \vfill
  \begin{center}
    \singlespacing
    Copyright \@author\ \@copyrightyear\\
    ALL RIGHTS RESERVED
  \end{center}
  \clearpage
  \olemiss@hypersetup{pageanchor=true}%
}

\newcommand*{\makeabstract}{%
  \newpage
  \vspace*{.75in}%
  \setcounter{page}{2}%
  \olemiss@phantomsection
  \addcontentsline{toc}{chapter}{\normalfont ABSTRACT}%
  \begin{center}
    ABSTRACT
  \end{center}
  \@abstract
  \clearpage
}

\newcommand*{\makededication}{%
  \ifdefined\@dedication
    \vspace*{.75in}%
    \olemiss@phantomsection
    \addcontentsline{toc}{chapter}{\normalfont DEDICATION}%
    \begin{center}
      DEDICATION
    \end{center}
    \@dedication
    \clearpage
  \fi
}

\newcommand*{\makeacknowledgements}{%
  \ifdefined\@acknowledgements
    \vspace*{.75in}%
    \olemiss@phantomsection
    \addcontentsline{toc}{chapter}{\normalfont ACKNOWLEDGEMENTS}%
    \begin{center}
      ACKNOWLEDGEMENTS
    \end{center}
    \@acknowledgements
    \clearpage
  \fi
}

% ============================================================================
% Contents and front-matter lists
% ============================================================================

\newcommand*{\maketoc}{\tableofcontents}

\newcommand*{\makelot}{%
  \ifolemiss@lot
    \olemiss@phantomsection
    \addcontentsline{toc}{chapter}{\normalfont LIST OF TABLES}%
    \listoftables
  \fi
}

\newcommand*{\makelof}{%
  \ifolemiss@lof
    \olemiss@phantomsection
    \addcontentsline{toc}{chapter}{\normalfont LIST OF FIGURES}%
    \listoffigures
  \fi
}

\ifolemiss@los
  \RequirePackage[
    toc=true,
    section=chapter
  ]{glossaries-extra}
  \newglossary[slg]{symbolslist}{sls}{slo}{LIST OF SYMBOLS}
  \newcommand*{\makelos}{%
    \printunsrtglossary[
      type=symbolslist,
      title={LIST OF SYMBOLS},
      toctitle={LIST OF SYMBOLS}
    ]%
  }
\else
  \newcommand*{\makelos}{}
\fi

\newcommand*{\makefrontmatter}{%
  \bodyspacing
  \frontmatter
  \maketitlepage
  \makecopyrightpage
  \makeabstract
  \makededication
  \makeacknowledgements
  \clearpage
  \olemiss@hypersetup{linkcolor=black}%
  \maketoc
  \clearpage
  \makelot
  \clearpage
  \makelof
  \clearpage
  \makelos
  \clearpage
  \mainmatter
}

% ============================================================================
% Heading formatting -- LaTeX 2026 template interface
% ============================================================================

\renewcommand{\chaptername}{}

% A shared hanging format for part and chapter headings.
\DeclareInstance{headformat}{olemiss-chapter-hang}{hang}{
  heading-indent   = 0pt,
  number-title-sep = 1em,
  title-format     = \MakeUppercase{#1}
}

% Part headings: CHAPTER I: TITLE
\EditInstance{heading}{part}{
  heading-decls       = \normalfont\centering,
  title-decls         = \normalfont,
  prefix              = CHAPTER,
  number-format       = \theheading:,
  headformat-instance = olemiss-chapter-hang
}

% Chapter headings: 1 TITLE
\EditInstance{heading}{chapter}{
  heading-decls        = \normalfont\centering,
  title-decls          = \normalfont,
  after-penalty-vspace = .75in,
  after-vspace         = 40pt,
  headformat-instance  = olemiss-chapter-hang
}

% Section headings.
\EditInstance{heading}{section}{
  heading-decls = \normalfont\bfseries,
  number-format = \theheading
}

\EditInstance{headformat}{section}{
  number-title-sep = 1em
}

% Subsection headings.
\EditInstance{heading}{subsection}{
  heading-decls = \normalfont\bfseries,
  number-format = \theheading
}

\EditInstance{headformat}{subsection}{
  number-title-sep = 1em
}

% ============================================================================
% Names of the table of contents and lists
% ============================================================================

\renewcommand{\contentsname}{TABLE OF CONTENTS}
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\listtablename}{LIST OF TABLES}

% ============================================================================
% Table-of-contents entry formatting
% ============================================================================

\renewcommand*\l@part[2]{%
  \ifnum\c@tocdepth>-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{0.25em}%
    \begingroup
      \bfseries\normalsize
      \def\@dotsep{2.9}%
      \@dottedtocline{-1}{0em}{1.4em}{#1}{#2}%
    \endgroup
  \fi
}

\renewcommand*\l@chapter[2]{%
  \ifnum\c@tocdepth>\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{0.25em}%
    \begingroup
      \normalfont\normalsize
      \def\@dotsep{2.9}%
      \@dottedtocline{0}{0em}{1.5em}{#1}{#2}%
    \endgroup
  \fi
}

\renewcommand*\l@section{%
  \@dottedtocline{1}{1.5em}{2.5em}%
}

\renewcommand*\l@subsection{%
  \@dottedtocline{2}{2.5em}{3.0em}%
}

% ============================================================================
% List of appendices
% ============================================================================

\newcommand*{\listofappendices}{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \olemiss@phantomsection
  \addcontentsline{toc}{chapter}{LIST OF APPENDICES}%
  \begingroup
    \let\clearpage\relax
    \let\cleardoublepage\relax
    \part*{LIST OF APPENDICES}%
  \endgroup
}

% ============================================================================
% Figure and table captions
% ============================================================================

\AddToHook{cmd/@makecaption/before}[olemissthesis/caption-format]{%
  \small
  \itshape
  \setstretch{1}%
}

\endinput
%%
%% End of file `olemissthesis.cls'.