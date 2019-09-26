set background=light
highlight clear
if exists("syntax_on")
	syntax reset
endif


highlight Preprocessor guifg=#804000
highlight link Include cPreprocessor
highlight link Define cPreprocessor
highlight link Included cPreprocessor

highlight Number guifg=#FF8000
highlight link Numbers cNumber

highlight Conditional guifg=#0000FF
highlight Type guifg=#8001FF
highlight link Structure cType

highlight Comment guifg=#008000

highlight String guifg=#808080
highlight link Character cString

highlight Delimiter guifg=#000080 guibg=NONE
"highlight Delimiter guifg=#FF0000 guibg=NONE
highlight link Operator Delimiter
highlight link Constant Delimiter
highlight link Paren Delimiter
highlight link ErrInParen cParen
highlight MatchParen guifg=#FF0000 guibg=NONE

highlight link Repeat Conditional
highlight link Statement Conditional
highlight Function guifg=NONE
highlight link cUserFunction cFunction
highlight link cAnsiName cFunction
highlight link cErrInBracket cBracket

highlight CursorLineNr guibg=#E4E4E4 guifg=#808080
highlight CursorLine guibg=#e8e8ff
highlight LineNr guibg=#E4E4E4 guifg=#808080
highlight SpecialKey guifg=#C0C0C0
highlight Search guibg=#C0C0C0
"highlight CoursorLine guibg=#ff0000 guifg=#00FF00
"number bar e4e4e4
"numbers 808080
"
