set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set wrapscan
set showmatch
set wildmenu
set formatoptions+=mM
set number
set ruler
set nolist
set listchars=
set wrap
set laststatus=2
set cmdheight=2
set showcmd
set notitle
set hlsearch
set visualbell t_vb=
set noswapfile
set backspace=start,eol,indent
let mapleader = ","
augroup vimrc
  autocmd!
augroup END

"-----------------------------
" Neobundle
"-----------------------------
if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/neobundle.vim/
endif

call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Repos
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'tsukkee/unite-tag.git'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
call neobundle#end()
NeoBundleCheck
syntax on
filetype plugin indent on

"-----------------------------
" neosnippet
"-----------------------------
" snippets key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" snippets directory
let g:neosnippet#snippets_directory='~/.vim/snippets/'

"-----------------------------
" unite.vim
"-----------------------------
let g:unite_source_history_yank_enable =1
let g:unite_source_grep_default_opts   = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt  = ''
if executable('ag')
  let g:unite_source_grep_command = 'ag'
endif
nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite bookmark<CR>
nnoremap <silent> <leader>uba :<c-u>unitebookmarkadd<cr>
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,gg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

"-----------------------------
" lightline.vim
"-----------------------------
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
\ }

"-----------------------------
" neocomplcache
"-----------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

"-----------------------------
" unite-tag
"-----------------------------
autocmd vimrc BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\|  endif
autocmd vimrc BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-t> :<C-u>Unite jump<CR>
\|  endif

let g:unite_source_tag_max_fname_length = 40

"-----------------------------
" auto-ctags.vim
"-----------------------------
let g:auto_ctags = 1
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes'
let g:auto_ctags_directory_list = ['.git']
set tags+=.git/tags
set tags+=.git/ruby.tags

"-------------------------------
" ファイルに応じてタブ幅を変更
"-------------------------------
autocmd vimrc BufNewFile,BufRead *.rb    set tabstop=2 shiftwidth=2
autocmd vimrc BufNewFile,BufRead *.erb   set tabstop=2 shiftwidth=2
autocmd vimrc BufNewFile,BufRead *.vimrc set tabstop=2 shiftwidth=2

"-------------------------------
" ファイル更新時常に自動保存する
"-------------------------------
autocmd vimrc CursorHold,InsertLeave * silent! wa

"-------------------------------
" .localが存在する場合は読み込む
"-------------------------------
if filereadable( $HOME . "/.vimrc.local" )
  source ~/.vimrc.local
endif
