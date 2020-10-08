# Vim tricks

% 可以在括号匹配之间跳转，在找成对括号的时候比较有用

ctrl+] 跳转到定义(也有插件使用gd, goto definition)，一般需要 tags 或者相关的编程语言插件支持。

ctrl+o 跳转到上一个跳转位置，比如上边我们用 ctrl+] 跳转到代码定义之后，使用这 ctrl+o 跳转回来

ctrl+i 前进到下一个跳转位置，配合 ctrl+o 可以在跳转位置之间前后移动

gf: goto file, 如果你在 vim 里有文件路径，不管是相对还是绝对路径，可以跳转到该文件

# Nvim-R mappings

Menu entry                                Default shortcut~
Start/Close
  . Start R (default)                                  \rf
  . Start R (custom)                                   \rc
  --------------------------------------------------------
  . Close R (no save)                                  \rq
  . Stop R                                          :RStop
-----------------------------------------------------------

Send
  . File                                               \aa
  . File (echo)                                        \ae
  . File (open .Rout)                                  \ao
  --------------------------------------------------------
  . Block (cur)                                        \bb
  . Block (cur, echo)                                  \be
  . Block (cur, down)                                  \bd
  . Block (cur, echo and down)                         \ba
  --------------------------------------------------------
  . Chunk (cur)                                        \cc
  . Chunk (cur, echo)                                  \ce
  . Chunk (cur, down)                                  \cd
  . Chunk (cur, echo and down)                         \ca
  . Chunk (from first to here)                         \ch
  --------------------------------------------------------
  . Function (cur)                                     \ff
  . Function (cur, echo)                               \fe
  . Function (cur and down)                            \fd
  . Function (cur, echo and down)                      \fa
  --------------------------------------------------------
  . Selection                                          \ss
  . Selection (echo)                                   \se
  . Selection (and down)                               \sd
  . Selection (echo and down)                          \sa
  . Selection (evaluate and insert output in new tab)  \so
  --------------------------------------------------------
  . Send motion region                                 \m{motion}
  --------------------------------------------------------
  . Paragraph                                          \pp
  . Paragraph (echo)                                   \pe
  . Paragraph (and down)                               \pd
  . Paragraph (echo and down)                          \pa
  --------------------------------------------------------
  . Line                                                \l
  . Line (and down)                                     \d
  . Line (and new one)                                  \q
  . Left part of line (cur)                       \r<Left>
  . Right part of line (cur)                     \r<Right>
  . Line (evaluate and insert the output as comment)    \o
  . All lines above the current one                    \su
-----------------------------------------------------------

Command
  . List space                                         \rl
  . Clear console                                      \rr
  . Remove objects and clear console                   \rm
  --------------------------------------------------------
  . Print (cur)                                        \rp
  . Names (cur)                                        \rn
  . Structure (cur)                                    \rt
  . View data.frame (cur) in new tab                   \rv
  . View data.frame (cur) in horizontal split          \vs
  . View data.frame (cur) in vertical split            \vv
  . View head(data.frame) (cur) in horizontal split    \vh
  . Run dput(cur) and show output in new tab           \td
  --------------------------------------------------------
  . Arguments (cur)                                    \ra
  . Example (cur)                                      \re
  . Help (cur)                                         \rh
  --------------------------------------------------------
  . Summary (cur)                                      \rs
  . Plot (cur)                                         \rg
  . Plot and summary (cur)                             \rb
  --------------------------------------------------------
  . Set working directory (cur file path)              \rd
  --------------------------------------------------------
  . Sweave (cur file)                                  \sw
  . Sweave and PDF (cur file)                          \sp
  . Sweave, BibTeX and PDF (cur file) (Linux/Unix)     \sb
  --------------------------------------------------------
  . Knit (cur file)                                    \kn
  . Knit, BibTeX and PDF (cur file) (Linux/Unix)       \kb
  . Knit and PDF (cur file)                            \kp
  . Knit and Beamer PDF (cur file)                     \kl
  . Knit and HTML (cur file, verbose)                  \kh
  . Knit and ODT (cur file)                            \ko
  . Knit and Word Document (cur file)                  \kw
  . Markdown render (cur file)                         \kr
  . Spin (cur file) (only .R)                          \ks
  --------------------------------------------------------
  . Open attachment of reference (Rmd, Rnoweb)         \oa
  . Open PDF (cur file)                                \op
  . Search forward (SyncTeX)                           \gp
  . Go to LaTeX (SyncTeX)                              \gt
  --------------------------------------------------------
  . Debug (function)                                   \db
  . Undebug (function)                                 \ud
  --------------------------------------------------------
  . Build tags file (cur dir)                  :RBuildTags
-----------------------------------------------------------

Edit
  . Insert "<-"                                          _
  . Complete object name                     CTRL-X CTRL-O
  --------------------------------------------------------
  . Indent (line)                                       ==
  . Indent (selected lines)                              =
  . Indent (whole buffer)                             gg=G
  --------------------------------------------------------
  . Toggle comment (line, sel)                         \xx
  . Comment (line, sel)                                \xc
  . Uncomment (line, sel)                              \xu
  . Add/Align right comment (line, sel)                 \;
  --------------------------------------------------------
  . Go (next R chunk)                                  \gn
  . Go (previous R chunk)                              \gN
-----------------------------------------------------------

Object Browser
  . Open/Close                                         \ro
  . Expand (all lists)                                 \r=
  . Collapse (all lists)                               \r-
  . Toggle (cur)                                     Enter
-----------------------------------------------------------

