"Recognise docstring as comment
"Reference: https://neovim.io/doc/user/syntax.html
syn region Comment start=/"""/ end=/"""/ contains=pythonTodo,@Spell
