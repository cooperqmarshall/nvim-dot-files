" Cooper Marshall's nvim config
set hidden

" Set <leader> to SPACE
let mapleader = " "

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches 
set hlsearch
set ignorecase
set smartcase

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
if has('mouse')
  set mouse=a
endif

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number
set cursorline

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=0

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Window tab control
nnoremap H gT
nnoremap L gt

" Splits
set splitbelow
set splitright

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set tabstop=4
" set expandtab

" Better Save and Quit
nnoremap <CR> :w<CR>
nnoremap <leader>q :wq<CR>
nnoremap <leader>Q :q<CR>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Automates vim-plug install:
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" The default plugin directory is (Linux/macOS): '~/.vim/plugged'
call plug#begin()
" Plug 'tpope/vim-sensible'
Plug 'nvim-lualine/lualine.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ellisonleao/gruvbox.nvim'
Plug 'darazaki/indent-o-matic'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-test/vim-test'
Plug 'mhinz/vim-signify'
Plug 'vim-scripts/dbext.vim'
call plug#end()

" LuaLine Config
lua << END
require('lualine').setup { options = { theme = 'gruvbox' }}
END

" Nerd Tree config
nnoremap <C-n> :NERDTreeToggleVCS<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" FZF
nnoremap <C-p> :FZF<CR>
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

" COC Config
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" COC Extensions
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-pyright',
  \ 'coc-prettier',
  \ 'coc-sql',
  \ '@yaegassy/coc-volar',
  \ 'coc-highlight',
  \ 'coc-java',
  \ 'coc-go',
  \ 'coc-pairs'
  \]

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
set termguicolors
set updatetime=1000

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Gruvbox theme
set background=dark
colorscheme gruvbox

" Detect indent
lua << END
require('indent-o-matic').setup {
  -- The values indicated here are the default
  max_lines = 2048,

  -- Space indentations that should be detected
  standard_widths = { 2, 4},
}
END

" Indent Line
lua << END
vim.opt.termguicolors = true
--vim.cmd [[highlight IndentBlanklineContextStart guifg=#e0e0e0 gui=underline]]
require("indent_blankline").setup {
  char = "▏",
  char_blankline = "▏",
  use_treesitter = true,
  show_trailing_blankline_indent = true,
  --use_treesitter_scope = true,
  show_current_context = true,
  show_current_context_start = true,
  --context_highlight_list = {"IndentBlanklineContextStart"}
}
END

" Tree Sitter
lua << END
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "python", "javascript", "go", "html", "css", "vim", "vue"},
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
END


" vim test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "neovim"
let test#go#gotest#options  = {
  \ 'all':   '-v -cover',
  \ 'suite': '-v -cover ./...',
\}

" vim signify
set updatetime=100

