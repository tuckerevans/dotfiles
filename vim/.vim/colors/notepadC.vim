set background=light
highlight clear
if exists("syntax_on")
	syntax reset
endif


highlight cPreprocessor guifg=#804000
highlight link cInclude cPreprocessor
highlight link cDefine cPreprocessor
highlight link cIncluded cPreprocessor

highlight cNumber guifg=#FF8000
highlight link cNumbers cNumber

highlight cConditional guifg=#0000FF
highlight cType guifg=#8001FF
highlight link cStructure cType
highlight cStruct guibg=#00FF00

highlight cComment guifg=#008000

highlight cString guifg=#808080
highlight link cCharacter cString

highlight Delimiter guifg=#000080 guibg=NONE
"highlight Delimiter guifg=#FF0000 guibg=NONE
highlight link cOperator Delimiter
highlight link cConstant Delimiter
highlight link cParen Delimiter
highlight link cErrInParen cParen
highlight MatchParen guifg=#FF0000 guibg=NONE

highlight link cRepeat cConditional
highlight link cStatement cConditional
highlight cFunction guifg=NONE
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
