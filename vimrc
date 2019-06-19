:set nocompatible

filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
set noshowmode
set autoread
set cursorline
au FocusGained,BufEnter * :silent! ! scriptencoding utf-8
set selection=exclusive
set completeopt=longest,menuone


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
    Plug 'tpope/vim-markdown'
    Plug 'scrooloose/nerdtree'
    Plug 'mhinz/vim-signify'
    Plug 'majutsushi/tagbar'
    Plug 'craigemery/vim-autotag'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdcommenter'
    Plug 'honza/vim-snippets'

    " Install nightly build, replace ./install.sh with install.cmd on windows
    Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " Plug 'plasticboy/vim-markdown'
    Plug 'ericbn/vim-relativize'
    " Plug 'rizzatti/dash.vim'
    Plug 'mhinz/vim-startify'
    " syntax highlighting
    Plug 'sheerun/vim-polyglot'
    " easy paste
    " Plug 'roxma/vim-paste-easy'

    " color themes
    Plug 'rakr/vim-one'

    Plug 'janko/vim-test'

    Plug 'jiangmiao/auto-pairs'
    " Plug 'ludovicchabant/vim-gutentags'
    " Plug 'prabirshrestha/async.vim'
    " Plug 'prabirshrestha/vim-lsp'

    " Plug 'ncm2/float-preview'
    Plug 'ronakg/quickr-preview.vim'

    Plug 'christoomey/vim-tmux-navigator'

    call plug#end()
" }
map <C-e> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

colorscheme one
set background=dark

" Formatting {

        set nowrap                      " Do not wrap long lines
        set autoindent                  " Indent at the same level of the previous line
        " set smartindent
        set shiftwidth=0                " Use indents of 4 spaces
        set expandtab                   " Tabs are spaces, not tabs
        set tabstop=2                   " An indentation every four columns
        set softtabstop=2               " Let backspace delete indent
        set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
        set splitright                  " Puts new vsplit windows to the right of the current
        set splitbelow                  " Puts new split windows to the bottom of the current
        "set matchpairs+=<:>             " Match, to be used with %
        set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
        "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
        " Remove trailing whitespaces and ^M chars
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

        let g:python_host_prog ="/usr/local/bin/python"
        let g:python3_host_prog ="/usr/local/bin/python3"
        let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh', 'rust', 'haskell', 'c', 'cpp']
" }



" Key (re)Mappings {
        let mapleader = " "
        " really save a file when forgetting sudo
        cmap w!! w !sudo tee % >/dev/null
        " move in visual line instead of file line
        noremap j gj
        noremap k gk
        " Find merge conflict markers
        map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" }

" Plugins {

        " ale {
						" let g:ale_fix_on_save = 1
						" let g:ale_lint_on_text_changed = 'normal'
						" let g:ale_set_loclist = 1
						" let g:ale_sign_error = '⤫'
						" let g:ale_sign_warning = '⚠'
						" let g:ale_python_pylint_use_msg_id = 1
						" let g:ale_sign_column_always = 1
						" let g:ale_linters = {
						"       \ 'python': ['pylint'],
						"       \ 'java': ['checkstyle', 'javac'],
						"       \}
						" let g:ale_fixers = {
						"       \   '*': ['remove_trailing_lines', 'trim_whitespace'],
						"       \   'python': ['yapf'],
						"       \   'java': ['google_java_format'],
						"       \}
        " }

        " auto pair {
						let g:AutoPairsFlyMode = 0
        " }

        " dash {
						:nmap <silent> <leader>d <Plug>DashSearch
						let g:dash_map = {
									\ 'java' : ['android', 'java'],
									\ 'python': ['python'],
									\ 'go': ['go'],
									\ }
        " }

        " deoplete {
						" deoplete tab-complete
						" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
						" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
            "
						" call deoplete#custom#option({
						" \ 'smart_case': v:true,
						" \ 'ignore_case': v:true,
						" \ })
						" let g:deoplete#enable_at_startup = 1
						" let g:deoplete#sources#jedi#popup_select_first = 1
						" let g:python_host_prog ="/usr/local/google/home/zyichi/.pyenv/versions/neovim2/bin/python"
						" let g:python3_host_prog ="/usr/local/google/home/zyichi/.pyenv/versions/neovim3/bin/python3"
						" highlight Pmenu ctermbg=Blue guibg=#606060
						" highlight PmenuSel ctermbg=White guifg=#dddd00 guibg=#1f82cd
						" highlight PmenuSbar ctermbg=Blue guibg=#d6d6d6 }

        " echodoc {
						let g:echodoc#enable_at_startup = 1
        " }

        " float-preview {
						let g:float_preview#docked = 0
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

						nnoremap <silent> <C-f> :FZF<CR>

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

        " gutentags {
						" let g:gutentags_ctags_tagfile = '.git/tags'
        " }

        " lsp {
						" use vim-lsp
						" au User lsp_setup call lsp#register_server({
						"   \ 'name': 'Kythe Language Server',
						"   \ 'cmd': {server_info->['/google/bin/releases/grok/tools/kythe_languageserver', '--google3']},
						"   \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto'],
						"   \})
						"
						" if executable('pyls')
						"   au User lsp_setup call lsp#register_server({
						"       \ 'name': 'pyls',
						"       \ 'cmd': {server_info->['pyls']},
						"       \ 'whitelist': ['python'],
						"       \ 'workspace_config': {'pyls': {'configurationSource':['pycodestyle'],'plugins': {'pycodestyle': {'enabled': v:false}}}}
						"       \ })
						" endif
            "
						" au User lsp_setup call lsp#register_server({
						"   \ 'name': 'Cider Language Server',
						"   \ 'cmd': {server_info->['/google/bin/releases/editor-devtools/ciderlsp', '--tooltag=vim-lsp', '--noforward_sync_responses']},
						"   \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto'],
						"   \})
						" nnoremap gd :<C-u>LspDefinition<CR>
						" nnoremap gr :<C-u>LspReference<CR>
						" nnoremap <S-k> :<C-u>LspHover<CR>
            "
						" use neovim-languageClient
						" " Required for operations modifying multiple buffers like rename.
						" set hidden
						" let g:LanguageClient_serverCommands = {
						"        \ 'java': ['/google/bin/releases/grok/tools/kythe_languageserver', '--google3'],
						"        \ 'go': ['/google/bin/releases/grok/tools/kythe_languageserver', '--google3'],
						"        \ 'python': ['/google/bin/releases/grok/tools/kythe_languageserver', '--google3'],
						"       \ }
						" let g:LanguageClient_windowLogMessageLevel = "Error"
						" let g:LanguageClient_rootMarkers = ['google3']
						" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
						" " Or map each action separately
						" nnoremap <silent> <F1> :call LanguageClient#textDocument_hover()<CR>
						" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
						" nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>
        " }

        " one color scheme {
						let g:one_allow_italics = 1
						"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
						"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
						" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
						if (has("termguicolors"))
							set termguicolors
						endif
        " }

        " snippet {
						" UltiSnips Plugin Configuration
						" let g:UltiSnipsExpandTrigger="<c-s>"
						" let g:UltiSnipsJumpForwardTrigger="<S-tab>"
						" let g:UltiSnipsJumpBackwardTrigger="<c-p>"
						"
						" " If you want :UltiSnipsEdit to split your window.
						" let g:UltiSnipsEditSplit="vertical"

						" NeoSnippet Plugin key-mappings.
						" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
						" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
						" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
						" xmap <C-k>     <Plug>(neosnippet_expand_target)

						" SuperTab like snippets behavior.
						" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
						" imap <expr><TAB>
						" \ pumvisible() ? "\<C-n>" :
						" \ neosnippet#expandable_or_jumpable() ?
						" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
						" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
						" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
            "
						" " For conceal markers.
						" if has('conceal')
						"   set conceallevel=2 concealcursor=niv
						"   " let g:vim_markdown_conceal = 0
						" endif
            "
						" " enable insert parenthesis after auto completion
						" let g:neosnippet#enable_completed_snippet = 1
						" " autocmd CompleteDone * call neosnippet#complete_done()
            "
						" let g:neopairs#enable = 1
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

        " Startify {
						let g:startify_change_to_vcs_root = 1
						let g:startify_enable_unsafe = 1
        " }

        " quickr-preview {
						let g:quickr_preview_position = 'right'
						let g:quickr_preview_on_cursor = 1
        " }

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
            let g:airline#extensions#tabline#enabled = 1
            let g:airline_powerline_fonts = 1
						let g:airline#extensions#ale#enabled = 1
						let g:airline#extensions#gutentags#enabled = 0
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

        " vim-poweryank {
						map <Leader>y <Plug>(operator-poweryank-osc52)
        " }

        " coc {
						" if hidden is not set, TextEdit might fail.
						set hidden

						" Some servers have issues with backup files, see #649
						set nobackup
						set nowritebackup

						" Better display for messages
						set cmdheight=1

						" Smaller updatetime for CursorHold & CursorHoldI
						set updatetime=300

						" don't give |ins-completion-menu| messages.
						set shortmess+=c

						" always show signcolumns
						set signcolumn=yes

						" Use tab for trigger completion with characters ahead and navigate.
						" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
						inoremap <silent><expr> <TAB>
									\ pumvisible() ? "\<C-n>" :
									\ <SID>check_back_space() ? "\<TAB>" :
									\ coc#refresh()
						inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

						function! s:check_back_space() abort
							let col = col('.') - 1
							return !col || getline('.')[col - 1]  =~# '\s'
						endfunction

						" Use <c-space> to trigger completion.
						inoremap <silent><expr> <c-space> coc#refresh()

						" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
						" Coc only does snippet and additional edit on confirm.
						inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

						" Use `[c` and `]c` to navigate diagnostics
						nmap <silent> [c <Plug>(coc-diagnostic-prev)
						nmap <silent> ]c <Plug>(coc-diagnostic-next)

						" Remap keys for gotos
						nmap <silent> gd <Plug>(coc-definition)
						nmap <silent> gy <Plug>(coc-type-definition)
						nmap <silent> gi <Plug>(coc-implementation)
						nmap <silent> gr <Plug>(coc-references)

						" Use K to show documentation in preview window
						nnoremap <silent> K :call <SID>show_documentation()<CR>

						function! s:show_documentation()
							if (index(['vim','help'], &filetype) >= 0)
								execute 'h '.expand('<cword>')
							else
								call CocAction('doHover')
							endif
						endfunction

						" Highlight symbol under cursor on CursorHold
						autocmd CursorHold * silent call CocActionAsync('highlight')

						" Remap for rename current word
						nmap <leader>rn <Plug>(coc-rename)

						" Remap for format selected region
						xmap <leader>f  <Plug>(coc-format-selected)
						nmap <leader>f  <Plug>(coc-format-selected)

						augroup mygroup
							autocmd!
							" Setup formatexpr specified filetype(s).
							autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
							" Update signature help on jump placeholder
							autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
						augroup end

						" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
						xmap <leader>a  <Plug>(coc-codeaction-selected)
						nmap <leader>a  <Plug>(coc-codeaction-selected)

						" Remap for do codeAction of current line
						nmap <leader>ac  <Plug>(coc-codeaction)
						" Fix autofix problem of current line
						nmap <leader>qf  <Plug>(coc-fix-current)

						" Use `:Format` to format current buffer
						command! -nargs=0 Format :call CocAction('format')

						" Use `:Fold` to fold current buffer
						command! -nargs=? Fold :call     CocAction('fold', <f-args>)


						" Add diagnostic info for https://github.com/itchyny/lightline.vim
						let g:lightline = {
									\ 'colorscheme': 'wombat',
									\ 'active': {
									\   'left': [ [ 'mode', 'paste' ],
									\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
									\ },
									\ 'component_function': {
									\   'cocstatus': 'coc#status'
									\ },
									\ }


						highlight Pmenu ctermbg=Blue guibg=#606060
						highlight PmenuSel ctermbg=White guifg=#dddd00 guibg=#1f82cd
						highlight PmenuSbar ctermbg=Blue guibg=#d6d6d6

						" Using CocList
						" Show all diagnostics
						nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
						" Manage extensions
						nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
						" Show commands
						nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
						" Find symbol of current document
						nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
						" Search workspace symbols
						nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
						" Do default action for next item.
						nnoremap <silent> <space>j  :<C-u>CocNext<CR>
						" Do default action for previous item.
						nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
						" Resume latest coc list
						nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

            cmap CC CocCommand
            cmap CS CocConfig

            " coc-snippets
            " Use <C-l> for trigger snippet expand.
            imap <C-l> <Plug>(coc-snippets-expand)

            " Use <C-j> for select text for visual placeholder of snippet.
            vmap <C-j> <Plug>(coc-snippets-select)

            " Use <C-j> for jump to next placeholder, it's default of coc.nvim
            let g:coc_snippet_next = '<c-j>'

            " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
            let g:coc_snippet_prev = '<c-k>'

            " Use <C-j> for both expand and jump (make expand higher priority.)
            imap <C-j> <Plug>(coc-snippets-expand-jump)
        " }
  " }

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
highlight CursorLine cterm=underline gui=underline
