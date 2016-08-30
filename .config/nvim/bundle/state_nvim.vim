let [plugins, ftplugin] = dein#load_cache_raw(['/Users/suehara/.config/nvim/init.vim'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/suehara/.config/nvim//bundle'
let g:dein#_runtime_path = '/Users/suehara/.config/nvim//bundle/.dein'
let &runtimepath = '/Users/suehara/.config/nvim,/etc/xdg/nvim,/Users/suehara/.local/share/nvim/site,/usr/local/share/nvim/site,/Users/suehara/.config/nvim//bundle/repos/github.com/Shougo/vimproc.vim,/Users/suehara/.config/nvim//bundle/.dein,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.1.5/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/suehara/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/suehara/.config/nvim/after,/Users/suehara/.config/nvim//bundle/repos/github.com/Shougo/dein.vim,/Users/suehara/.config/nvim//bundle/.dein/after'
filetype off
