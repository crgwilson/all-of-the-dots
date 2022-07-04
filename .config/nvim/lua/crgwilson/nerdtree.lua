local g = vim.g

g.NERDTreeMinimalUI = 1
g.NERDTreeShowHidden = 1
g.NERDTreeHijackNetrw = 0
g.NERDTreeWinSize = 31
g.NERDTreeChDirMode = 2
g.NERDTreeAutoDeleteBuffer = 1
g.NERDTreeShowBookmarks = 1
g.NERDTreeCascadeOpenSingleChildDir = 1
g.NERDTreeIgnore = { [[\.pyc$]], [[__pycache__]] }

vim.cmd([[autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif]])
