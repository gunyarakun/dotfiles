set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "gunya"

hi Normal   guifg=#fffff0 guibg=#00003F ctermfg=15   ctermbg=17
hi ErrorMsg guifg=#ffffff guibg=#287eff ctermfg=15   ctermbg=33
hi Visual   guifg=#8080ff guibg=fg gui=reverse ctermfg=105  cterm=reverse
hi VisualNOS guifg=#8080ff guibg=fg gui=reverse,underline ctermfg=105   cterm=reverse,underline

hi Todo guifg=#d14a14 guibg=#1248d1 ctermfg=166  ctermbg=26

hi Search guifg=#90fff0 guibg=#2050d0 ctermfg=123  ctermbg=26
hi IncSearch    guifg=#b0ffff guibg=#2050d0 ctermfg=159  ctermbg=26

hi SpecialKey   guifg=cyan ctermfg=14
hi Directory    guifg=cyan ctermfg=14
hi Title  guifg=#BDD094 gui=none ctermfg=150  cterm=none
hi WarningMsg guifg=red ctermfg=9
hi WildMenu guifg=yellow guibg=black ctermfg=11   ctermbg=0
hi ModeMsg  guifg=#22cce2 ctermfg=44
hi MoreMsg  ctermfg=darkgreen ctermfg=darkgreen
hi Question guifg=green gui=none ctermfg=10   cterm=none
hi NonText  guifg=#0030ff ctermfg=27

hi StatusLine   guifg=blue guibg=darkgray gui=none ctermfg=21   ctermbg=248   cterm=none
hi StatusLineNC guifg=black guibg=darkgray gui=none ctermfg=0  ctermbg=248   cterm=none
hi VertSplit guifg=black guibg=darkgray gui=none ctermfg=0   ctermbg=248   cterm=none
hi Folded   guifg=#808080 guibg=#000040 ctermfg=244  ctermbg=17
hi FoldColumn   guifg=#808080 guibg=#000040 ctermfg=244  ctermbg=17
hi LineNr   guifg=#90f020 ctermfg=118

hi DiffAdd  guibg=darkblue ctermbg=18
hi DiffChange   guibg=darkmagenta ctermbg=90
hi DiffDelete   gui=bold guifg=Blue guibg=DarkCyan cterm=bold ctermfg=21  ctermbg=30
hi DiffText   gui=bold guibg=Red cterm=bold ctermbg=9

hi Cursor guifg=#000020 guibg=#ffaf38 ctermfg=233  ctermbg=215
hi lCursor  guifg=#ffffff guibg=#000000 ctermfg=15   ctermbg=0

hi Comment  guifg=yellow ctermfg=11
hi Constant  guifg=green ctermfg=10
hi Special   guifg=#FFFFFF ctermfg=15   cterm=none
hi Identifier  guifg=#BDD094 ctermfg=150
hi Statement    guifg=#A9A900 gui=none ctermfg=142  cterm=none
hi PreProc   guifg=#ffffff gui=none ctermfg=15  cterm=none
hi type    guifg=LightBlue gui=none ctermfg=152   cterm=none
hi Underlined cterm=underline term=underline
hi Ignore guifg=bg ctermfg=bg
