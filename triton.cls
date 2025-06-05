% ===========================================================================
% Triton Preprint LaTeX Document Class
% A professional academic preprint template for UCSD researchers
%
% Author: Tianyang Liu <til040@ucsd.edu>
% ===========================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{triton}[2025/05/25 v1.0 Triton preprint class]

% ===========================================================================
% DOCUMENT FOUNDATION
% ===========================================================================
\LoadClassWithOptions{article}
\RequirePackage[top=2.5cm,bottom=2.5cm,left=2.5cm,right=2.5cm,columnsep=0.75cm]{geometry}
\RequirePackage{microtype}      % Typography enhancements
\RequirePackage{placeins}       % Float barrier control
\RequirePackage{hyphenat}       % Hyphenation control
\RequirePackage{parskip}        % Paragraph spacing
\RequirePackage{setspace}       % Line spacing
\RequirePackage[latin,english]{babel}
\RequirePackage{etoolbox}       % Programming tools
% \DisableLigatures[f]{family=sf*} % Disable ligatures in sans-serif fonts
% \DisableLigatures[f]{family=cmss}


% ===========================================================================
% VISUAL ELEMENTS
% ===========================================================================
% --- Graphics and Tables ---
\RequirePackage{graphicx}       % Image handling
\RequirePackage{subcaption}     % Sub-figures and sub-tables
\RequirePackage{booktabs}       % Professional tables
\RequirePackage{nicematrix}     % Enhanced matrices
\RequirePackage{multirow}       % Multi-row cells
\RequirePackage{bm}             % Bold math
\newcommand{\nm}[1]{#1}        % Nicematrix shorthand

% --- Color Definitions ---
\RequirePackage[most]{tcolorbox} % Colored boxes
\RequirePackage{xcolor}         % Color management

% UCSD Brand Colors
\definecolor{ucsdnavy}{HTML}{003153}    % Primary brand color
\definecolor{ucsdblue}{HTML}{0084C6}    % Secondary blue
\definecolor{ucsdgold}{HTML}{C69214}    % Accent gold
\definecolor{ucsdlightblue}{HTML}{8FBAC8} % Light blue
\definecolor{ucsdgray}{HTML}{747678}    % Neutral gray
\definecolor{ucsdbg}{HTML}{FFFFFF}      % Background white
\definecolor{ucsdtext}{HTML}{1A1A1A}    % Main text color

% Harmonized Link Colors
\definecolor{citationcolor}{HTML}{1D6A7A} % Deep teal for citations
\definecolor{linkcolor}{HTML}{A67C00}     % Muted amber for internal links
\definecolor{urlcolor}{HTML}{3A6B50}      % Sage green for URLs
\definecolor{filecolor}{HTML}{3A6B50}     % Sage green for file links

% ===========================================================================
% TYPOGRAPHY
% ===========================================================================
\RequirePackage[T1]{fontenc}
\RequirePackage{sourcesanspro}   % Sans-serif font
\RequirePackage{sourceserifpro}  % Serif font
\RequirePackage{sourcecodepro}   % Monospace font
\renewcommand{\rmdefault}{SourceSerifPro-TLF}
\renewcommand{\sfdefault}{SourceSansPro-TLF}
\renewcommand*\ttdefault{SourceCodePro-TLF}
\linespread{1.05}                % Slightly increased line spacing

% ===========================================================================
% LINKS AND REFERENCES
% ===========================================================================
\RequirePackage{hyperref}
\RequirePackage[noabbrev,nameinlink]{cleveref}
\hypersetup{%
  colorlinks,
  linkcolor=linkcolor,
  citecolor=citationcolor,
  urlcolor=urlcolor,
  filecolor=filecolor
}
\RequirePackage[round,authoryear]{natbib}
\def\bibfont{\small}

% ===========================================================================
% DOCUMENT STRUCTURE
% ===========================================================================
% --- Section Formatting ---
\RequirePackage{titlesec}
\titleformat*{\paragraph}{\color{ucsdnavy}\sffamily\bfseries}
\titleformat{\section}{\Large\sffamily\bfseries\color{ucsdnavy}}{\thesection}{1em}{}
\titleformat{\subsection}{\large\sffamily\bfseries\color{ucsdnavy}}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\normalsize\sffamily\bfseries\color{ucsdnavy}}{\thesubsubsection}{1em}{}

\titlespacing*{\section}{0pt}{1.5ex plus 1ex minus .2ex}{1ex plus .2ex}
\titlespacing*{\subsection}{0pt}{1.2ex plus 1ex minus .2ex}{0.8ex plus .2ex}
\titlespacing*{\subsubsection}{0pt}{1ex plus 1ex minus .2ex}{0.5ex plus .2ex}

\DeclareTextFontCommand{\textbf}{\bfseries\sffamily\color{ucsdnavy}}

% --- Caption Formatting ---
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{custom}{: }
\DeclareCaptionFormat{custom}{{\sffamily\bfseries\color{ucsdnavy}#1#2}{\color{ucsdtext}#3}}
\captionsetup{singlelinecheck=false,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}

% ===========================================================================
% METADATA AND FRONT MATTER
% ===========================================================================
% --- List Building Helper ---
\renewcommand\addtolist[5][]{
  \begingroup
    \if\relax#3\relax\def\sep{}\else\def\sep{#5}\fi
    \let\protect\@unexpandable@protect
    \xdef#3{\expandafter{#3}\sep #4[#1]{#2}}%
  \endgroup
}

% --- Author Information ---
\newcommand\authorlist{}
\newcommand\authorformat[2][]{{\sffamily\bfseries\color{ucsdnavy}#2\ifx&#1&\else\textsuperscript{\color{ucsdgold}#1}\fi}}
\renewcommand\author[2][]{\addtolist[#1]{#2}{\authorlist}{\authorformat}{ }}

% Command to add manual separators
\newcommand\separatorformat[2][]{#2}
\newcommand\authorsep[1]{\addtolist{#1}{\authorlist}{\separatorformat}{}}

% Enhanced authorsep command with line spacing
\renewcommand\authorsep[1]{%
  \ifstrequal{#1}{\\}{%
    \addtolist{\\[3.5pt]}{\authorlist}{\separatorformat}{}%
  }{%
    \addtolist{#1}{\authorlist}{\separatorformat}{}%
  }%
}

% --- Affiliation Information ---
\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\normalsize\color{ucsdgray}\ifx&#1&\else\textsuperscript{\color{ucsdgold}#1}\fi#2}}
\newcommand\affiliation[2][]{\addtolist[#1]{#2}{\affiliationlist}{\affiliationformat}{ }}

% Command to add manual separators for affiliations (matches affiliation style)
\newcommand\affiliationseparatorformat[2][]{{\small\color{ucsdgray}#2}}
\newcommand\affiliationsep[1]{\addtolist{#1}{\affiliationlist}{\affiliationseparatorformat}{}}

% --- Contribution Notes ---
\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\small\color{ucsdgray}%
  \ifx&#1&\else\textsuperscript{\color{ucsdgold}#1}\fi #2}}
\newcommand\contribution[2][]{\addtolist[#1]{#2}{\contributionlist}{\contributionformat}{, }}

% --- Additional Metadata ---
\newcommand\metadatalist{}
\newcommand\metadataformat[2][]{{\small {\sffamily\bfseries\color{ucsdnavy} #1:} \color{ucsdtext}#2}}
\newcommand\metadata[2][]{\addtolist[#1]{#2}{\metadatalist}{\metadataformat}{\\[0.3em]}}

% --- Abstract and Contact Info ---
\renewcommand{\abstract}[1]{%
  \def\abstractlist{{\color{ucsdtext}\setlength{\parindent}{0pt}\ignorespaces#1\unskip}}}

\newcommand{\email}[1]{\href{mailto:#1}{\texttt{\color{urlcolor}#1}}}

\renewcommand\date[1]{\metadata[Date]{#1}}
\newcommand\correspondence[1]{\metadata[Correspondence]{#1}}

\renewcommand{\title}[1]{\newcommand{\titlelist}{{\ignorespaces\sffamily\bfseries\color{ucsdnavy}#1}}}

% --- Appendix Helper ---
\newcommand{\beginappendix}{%
  \appendix
  \section*{\sffamily\bfseries\color{ucsdnavy} Appendix}%
  \addcontentsline{toc}{section}{Appendix}%
}

% --- Logo Handling Commands ---
\def\triton@logos@left{}
\def\triton@logos@center{}
\def\triton@logos@right{}
\newcounter{triton@logocount@left}
\newcounter{triton@logocount@center}
\newcounter{triton@logocount@right}
\newcounter{triton@logocount@total}
\newlength{\triton@logo@spacing} % Define a length for spacing between logos in the same group
\setlength{\triton@logo@spacing}{5pt} % Set default spacing

\newcommand{\setlogospacing}[1]{\setlength{\triton@logo@spacing}{#1}} % Command to change spacing

\newcommand{\clearlogos}{%
  \def\triton@logos@left{}%
  \def\triton@logos@center{}%
  \def\triton@logos@right{}%
  \setcounter{triton@logocount@left}{0}%
  \setcounter{triton@logocount@center}{0}%
  \setcounter{triton@logocount@right}{0}%
  \setcounter{triton@logocount@total}{0}%
}
\clearlogos % Initialize

\newcommand{\addlogo}[2][center]{% Default position is center
  \ifnum\value{triton@logocount@total}<5\relax
    \stepcounter{triton@logocount@total}%
    \ifstrequal{#1}{left}{%
      \ifnum\value{triton@logocount@left}>0\appto\triton@logos@left{\hspace{\triton@logo@spacing}}\fi% Add space if not the first logo in this group
      \appto\triton@logos@left{{\includegraphics[height=0.5cm,keepaspectratio]{#2}}}%
      \stepcounter{triton@logocount@left}%
    }{%
      \ifstrequal{#1}{center}{%
        \ifnum\value{triton@logocount@center}>0\appto\triton@logos@center{\hspace{\triton@logo@spacing}}\fi% Add space
        \appto\triton@logos@center{{\includegraphics[height=0.5cm,keepaspectratio]{#2}}}%
        \stepcounter{triton@logocount@center}%
      }{%
        \ifstrequal{#1}{right}{%
          \ifnum\value{triton@logocount@right}>0\appto\triton@logos@right{\hspace{\triton@logo@spacing}}\fi% Add space
          \appto\triton@logos@right{{\includegraphics[height=0.5cm,keepaspectratio]{#2}}}%
          \stepcounter{triton@logocount@right}%
        }{%
          \ClassWarning{triton}{Invalid logo position '#1' for logo '#2'. Using 'center'.}%
          \ifnum\value{triton@logocount@center}>0\appto\triton@logos@center{\hspace{\triton@logo@spacing}}\fi% Add space
          \appto\triton@logos@center{{\includegraphics[height=0.5cm,keepaspectratio]{#2}}}%
          \stepcounter{triton@logocount@center}%
        }%
      }%
    }%
  \else
    \ClassWarning{triton}{Maximum of 5 total logos supported. Additional logo '#2' (position '#1') ignored.}%
  \fi
}

% ===========================================================================
% TITLE PAGE CONSTRUCTION
% ===========================================================================
% Fixed-width centered box for metadata
\newlength{\metadataboxwidth}
\setlength{\metadataboxwidth}{\textwidth}

\newcommand{\mymaketitle}{%
  \begingroup
    \setlength{\parindent}{0cm}%
    \setlength{\parskip}{0cm}%
    
    % --- Optional Header with Logos ---
    \ifnum\value{triton@logocount@total}>0\relax
      \begin{center}% Center the whole logo block and rule
        \vspace*{0.3cm}%
        % Minipage to constrain the width of logos and align with the rule
        \begin{minipage}{\textwidth}% The main bar for logos
          \noindent % Ensure no spurious indentation
          
          % Check if we have content in each position
          \ifdefempty{\triton@logos@center}{%
            % No center logos - use two-column layout
            \ifdefempty{\triton@logos@left}{%
              % Only right logos
              \hfill\triton@logos@right
            }{%
              \ifdefempty{\triton@logos@right}{%
                % Only left logos  
                \triton@logos@left\hfill
              }{%
                % Left and right logos, no center
                \triton@logos@left\hfill\triton@logos@right
              }%
            }%
          }{%
            % Has center logos - use three-column layout
            \begin{minipage}[t]{0.33\linewidth}
              \raggedright \triton@logos@left
            \end{minipage}%
            \begin{minipage}[t]{0.33\linewidth}
              \centering \triton@logos@center
            \end{minipage}%
            \begin{minipage}[t]{0.33\linewidth}
              \raggedleft \triton@logos@right
            \end{minipage}
          }%
        \end{minipage}% End of \textwidth minipage for logos
      
        % Decorative line separator
        {\color{ucsdgold}\rule{\textwidth}{0.5pt}}%
        \vspace{0.6cm}% Space after rule, before title
      \end{center}%
    \fi % End \ifnum\value{triton@logocount@total}>0

    % --- Title, Author, Metadata ---
    \begin{center} 
      {\fontsize{26pt}{30pt}\selectfont\sffamily\bfseries\color{ucsdnavy}\titlelist}\par
      \vskip 0.6cm
      {\fontsize{11}{16}\authorlist\\[4pt]}\par
      \vskip 0.3cm
      \begin{minipage}{\metadataboxwidth} % This is 0.9\textwidth
        \centering
        \affiliationlist\par
        \ifdefempty{\contributionlist}{}{\vskip 0.2cm\contributionlist\par}
        \ifdefempty{\metadatalist}{}{\vskip 0.25cm\metadatalist\par}
      \end{minipage}
      \vskip 0.8cm
    \end{center}

    % Abstract Box
    \tcbset{
      colback=ucsdgold!4!white,
      left=0.45cm,right=0.45cm,top=0.4cm,bottom=0.4cm,
      arc=8pt,
      enhanced,
      frame hidden,
    }
    \begin{tcolorbox}
      {\Large \sffamily\bfseries\color{ucsdnavy} Abstract}\\[1em]
      \abstractlist
    \end{tcolorbox}
    \vskip 0.6cm
    \FloatBarrier
  \endgroup
}

% --- Title Page Layout Selection ---
\if@twocolumn
  \renewcommand{\maketitle}{%
    \twocolumn[%
      \mymaketitle
      \vskip 0.5cm % Space after title block in two-column mode before main text
    ]%
  }
\else % Single column
  \renewcommand{\maketitle}{%
    \mymaketitle
    \vskip 0.3cm % Space after title block in one-column mode before main text
  }
\fi

% ===========================================================================
% END OF CLASS FILE
% ===========================================================================