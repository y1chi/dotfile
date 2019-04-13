set nocompatible

filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set selection=exclusive

" autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" Always switch to the current file directory
" plugin installs {
    call plug#begin('~/.vim/plugged')

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sensible'
    Plug 'scrooloose/nerdtree'
    Plug 'airblade/vim-gitgutter'
    Plug 'majutsushi/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdcommenter'
    Plug 'w0rp/ale'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
    Plug 'deoplete-plugins/deoplete-jedi'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'plasticboy/vim-markdown'
    Plug 'ericbn/vim-relativize'
    Plug 'rizzatti/dash.vim'
    " syntax highlighting
    Plug 'sheerun/vim-polyglot'
    " easy paste
    Plug 'roxma/vim-paste-easy'


    " color themes
    Plug 'rakr/vim-one'

    call plug#end()
" }
map <C-e> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

colorscheme one
set background=dark

" Formatting {

	set nowrap                      " Do not wrap long lines
	set autoindent                  " Indent at the same level of the previous line
	set shiftwidth=4                " Use indents of 4 spaces
	set expandtab                   " Tabs are spaces, not tabs
	set tabstop=4                   " An indentation every four columns
	set softtabstop=4               " Let backspace delete indent
	set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
	set splitright                  " Puts new vsplit windows to the right of the current
	set splitbelow                  " Puts new split windows to the bottom of the current
	"set matchpairs+=<:>             " Match, to be used with %
	set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	" Remove trailing whitespaces and ^M chars
	" To disable the stripping of whitespace, add the following to your
	" .vimrc.before.local file:
	"   let g:spf13_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
	"autocmd FileType go autocmd BufWritePre <buffer> Fmt
	autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
	autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
	" preceding line best in a plugin but here for now.

	autocmd BufNewFile,BufRead *.coffee set filetype=coffee

	" Workaround vim-commentary for Haskell
	autocmd FileType haskell setlocal commentstring=--\ %s
	" Workaround broken colour highlighting in Haskell
	autocmd FileType haskell,rust setlocal nospell

" }

" Key (re)Mappings {
	let mapleader = " "
	cmap w!! w !sudo tee % >/dev/null	" really save a file when forgetting sudo
	" move in visual line instead of file line
	noremap j gj
	noremap k gk
	" Find merge conflict markers
	map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>


" }

" Plugins {
    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        "   let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        let g:airline_powerline_fonts = 1
        if isdirectory(expand("~/.vim/plugged/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'molokai'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep=''  " Slightly fancier than '>'
                let g:airline_right_sep='' " Slightly fancier than '<'
            endif
        endif
    " }

    " ale {
        let g:ale_fix_on_save = 1
        let g:airline#extensions#ale#enabled = 1
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'javascript': ['eslint'],
        \   'python': ['yapf'],
        \}
    " }

    " deopelete {
        " deoplete tab-complete
        inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

        let g:deoplete#enable_at_startup = 1
        highlight Pmenu ctermbg=Blue guibg=#606060
        highlight PmenuSel ctermbg=White guifg=#dddd00 guibg=#1f82cd
        highlight PmenuSbar ctermbg=Blue guibg=#d6d6d6
    " }
    "
    " one color scheme {
        let g:one_allow_italics = 1
		"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
		"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
		" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
		if (has("termguicolors"))
			  set termguicolors
		endif
    " }
    " Nerd Commender {
        " Add spaces after comment delimiters by default
        let g:NERDSpaceDelims = 1
        " Use compact syntax for prettified multi-line comments
        let g:NERDCompactSexyComs = 1
        " Align line-wise comment delimiters flush left instead of following code indentation
        let g:NERDDefaultAlign = 'left'
        " Set a language to use its alternate delimiters by default
        let g:NERDAltDelims_java = 1
        " Add your own custom formats or override the defaults
        let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
        " Allow commenting and inverting empty lines (useful when commenting a region)
        let g:NERDCommentEmptyLines = 1
        " Enable trimming of trailing whitespace when uncommenting
        let g:NERDTrimTrailingWhitespace = 1
    " }

    " relativize {
        nnoremap <silent> <F2> :RelativizeToggle<CR>
        nnoremap <silent> <F3> :let [&number, &relativenumber] =
          \ [!&number && (g:relativize_with_number \|\| !g:relativize_enabled),
          \ !&relativenumber && g:relativize_enabled]<CR>
    " }

    " dash {
        :nmap <silent> <leader>d <Plug>DashSearch
        let g:dash_map = {
                \ 'java' : ['android', 'java'],
                \ 'python': ['python'],
                \ 'go': ['go'],
                \ }
    " }

    " FZF {
        nmap <Leader>f :Files<CR>
        nmap <Leader>t :Tags<CR>
        command! -bang -nargs=* Ag
          \ call fzf#vim#ag(<q-args>,
          \                 <bang>0 ? fzf#vim#with_preview('up:60%')
          \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
          \                 <bang>0)
        command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
        command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)
        nnoremap <silent> <Leader>// :Rg <C-R><C-W><CR>
        vnoremap <silent> <Leader>// y:Rg <C-R>"<CR>

        nnoremap <silent> <S-f> :FZF<CR>

        let g:fzf_colors =
		\ { 'fg':      ['fg', 'Normal'],
          \ 'bg':      ['bg', 'Normal'],
          \ 'hl':      ['fg', 'Comment'],
          \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
          \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
          \ 'hl+':     ['fg', 'Statement'],
          \ 'info':    ['fg', 'PreProc'],
          \ 'border':  ['fg', 'Ignore'],
          \ 'prompt':  ['fg', 'Conditional'],
          \ 'pointer': ['fg', 'Exception'],
          \ 'marker':  ['fg', 'Keyword'],
          \ 'spinner': ['fg', 'Label'],
          \ 'header':  ['fg', 'Comment'] }
    " }
" }
"
" Functions {
"   Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
" }
