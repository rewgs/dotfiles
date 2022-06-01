" =============================================================================
" NOTES
" =============================================================================

" How to comment out multiple lines:
" 1. Be on the first line you want to comment.
" 2. Press Ctrl+v to enter Visual Block mode.
" 3. Press j until you select the last line.
" 4. Press Shift+i, which will put the editor in Insert mode.
" 5. Press #. This will add a hash to the first line.
" 6. Press Escape, and a hash will be inserted on all the other selected
" lines.

" =============================================================================
" BRAINSTORM:
" =============================================================================

" There should be two modes: Command and Insert
" Since there are only two modes, they should be TOGGLED via Escape (freeing
" up i for new usages in Command mode)
" Visual, Visual Line, Visual Block, and Replace mode will now all be
" SUB-MODES of Command mode.
"
" While in Command mode, Visual/Visual Line/Visual Block should be momentary.
" Replace is actually a sub-mode of Command AND the Visual/etc modes, 
"
" Perhaps better to do this in the source code rather than via remapping.

" =============================================================================
" TO FIX:
" =============================================================================

" -Some lines are wrapping, some aren't...why? 
" -Keep p from adding a new line
" -Keep a commented line from adding a " after hitting Return
" -Close NERDTree with neovim
" -Create a table of contents?
" -Make Insert mode blue bar colors match Gruvbox theme
" -In Command mode, typing a number and then enter goes down an additional
" number of lines. Better for that to bring me to the line I'm entering. I.e.
" "I want to go to line 50" so I type "50" and then "Return."
" -Similarly, Shift+g without a number before it (breaking the "verb ->
" object model of vim) brings me to the last line. Weird! Let's keep this
" consistent:

" test line for fuckin about: THIS IS A TEST ADDED FROM DEBIAN VM

" =============================================================================
" BASIC VIM SETTINGS:
" =============================================================================

" COMMAND                                   NOTES
"
"lua require('config')                     " Looks at config.lua

" Basics
syntax on                                   " Enables syntax highlighting.
set shortmess=I                             " Removes the start screen
set noerrorbells belloff=all                " Disables beeping 

" Indentation
set tabstop=2                               " Dictates the width used to display an actual tabulation character (\t).
set softtabstop=0                           " Dictates how wide an indentation is supposed to span.             The special values of 0 means to replicate the value of 'tabstop'.
set shiftwidth=0                            " Sets the width used for shifting commands, such as <<, >>, or ==. The special value of 0 means to replicate the value of 'tabstop'.
set expandtab                               " Inserts spaces (equal to the number set in tabstop, etc) when tabbing
set autoindent                              " Adds indents automatically
set smartindent                             " ^...in a way that mostly works correctly most of the time

" Search and Commands
set ignorecase                              " Allows invoking commands, case-insensitive (i.e. type :nerdtree for :NERDTree)
set smartcase                               " If ^ is enabled, a search is case-sensitive only if it contains a capital letter
set incsearch                               " Enables incremental search
set hlsearch                                " Highlights searche results

" Line Numbers
set nu                                      " Activates line numbers
set number relativenumber                   " Turn hybrid line numbers on
set nu rnu                                  " Shows relative line numbers

" Misc
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set modifiable

" TURNING OFF WORD WRAP COMPLETELY: a saga
set nowrap

" enables line highlighting when in Insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul


" =============================================================================
" PLUGINS: 
" =============================================================================

call plug#begin('~/.config/nvim/plugged')
    
    " ============= Plugins
   
    " Indent Blankline - adds decoration to indents
    " https://github.com/lukas-reineke/indent-blankline.nvim
    " Plug 'lukas-reineke/indent-blankline.nvim'
    
    " feline
    Plug 'feline-nvim/feline.nvim'

    " fzf
    " https://github.com/junegunn/fzf.vim
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Lightline vim
    Plug 'itchyny/lightline.vim'

    " NERDTree
    Plug 'preservim/nerdtree'

    " telescope
    " https://github.com/nvim-telescope/telescope.nvim
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " TreeSitter
    Plug 'nvim-treesitter/nvim-treesitter', " {'do': ':TSUpdate'}
    " Plug 'nvim-treesitter/playground'

    " Accelerated-jk
    " https://github.com/rhysd/accelerated-jk
    Plug 'rhysd/accelerated-jk'
    if has('nvim')
      function! UpdateRemotePlugins(...)
        " Needed to refresh runtime files
        let &rtp=&rtp
        UpdateRemotePlugins
      endfunction
    
      Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
    else
      Plug 'gelguy/wilder.nvim'
    
      " To use Python remote plugin features in Vim, can be skipped
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif


    " nvim-yarp (required for wilder.nvim)
    " https://github.com/roxma/nvim-yarp
"    Plug 'roxma/vim-hug-neovim-rpc'                                     " Required for vim 8
"    Plug 'roxma/nvim-yarp', { 'do': 'pip install -r requirements.txt' } " Install this plugin

    " ============= Themes    * be sure to put used theme last *

    " Atom One Dark theme
    " Plug 'joshdick/onedark.vim'

    " gruvbox-flat theme
    Plug 'eddyekofo94/gruvbox-flat.nvim'

    " gruvbox theme
    Plug 'morhetz/gruvbox'
    
    " onedark
    Plug 'navarasu/onedark.nvim'

call plug#end()


" =============================================================================
" COLOR SCHEMES:
" =============================================================================

colorscheme gruvbox
" colorscheme onedark
" colorscheme gruvbox-flat

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" =============================================================================
" ADVANCED CUSTOMIZATIONS:
" =============================================================================

" NERDTree
autocmd VimEnter * NERDTree         " opens NERDTree on startup
autocmd BufEnter * NERDTreeMirror   " places cursor in file, not NERDTree
autocmd VimEnter * wincmd w
let NERDTreeQuitOnOpen=0
let NERDTreeShowHidden=1            " shows hidden files

" cursor
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" wilder.nvim
call wilder#setup({
    \ 'modes': [':', '/', '?'],
    \ 'next_key': '<Tab>',
    \ 'previous_key': '<S-Tab>',
    \ 'accept_key': '<Down>',
    \ 'reject_key': '<Up>',
    \ })
" =============================================================================
" REMAPPING:
" =============================================================================

" NOTE:
"   map:        recursive
"   noremap:    non-recursive
"   Prepending a mode letter limits the mode in which the mapping works. Mode letters:
"       n: normal only
"       v: visual and select
"       o: operator-pending
"       x: visual only
"       s: select only
"       i: insert
"       c: command-line
"       l: insert, command-line, regexp-search (and others. Collectively called "Lang-Arg" pseudo-mode)
"   i.e. "nmap" is a recursive mapping that applies only to Normal mode

" LEADER: remap from \ to ;
let mapleader=";"

" makes it so that exiting Insert mode doesn't push the cursor back one char
au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])


" PRIMARY NAVIGATION

" Command Mode:
" COMMAND                                   STOCK           DESIRED
" Start Insert mode: cursor                 i               i
" Start Insert mode: beginning of line      Shift+i         ?
" Start Insert mode: end of line            Shift+a         ?
" Delete from cursor to beginning of line   ?               a
" Delete from cursor to end of line         ?               s
" Back one word                             b               d
" Forward one word                          w               f
" Page Down (28 lines)                      Ctrl+d          Alt+j
" Page Up (28 lines)                        Ctrl+u          Alt+k
" Home (go to first line)                   ?               Ctrl+k
" End (go to last line)                     ?               Ctrl+j
" Delete character                          dw              ?
" Delete line                               dd              Ctrl+?
" Delete word                               db              Alt+?
" Undo                                      u               u
" Redo                                      Ctrl+r          r
" Append after the cursor                   a               e (like i, after)
" Open blank line below current line        o
" Open blank line above current line        Shift+o
" Expand cursor up                          ?               Alt+Shift+k
" Expand cursor down                        ?               Alt+Shift+j
" Replace selected text (possible?)
" Search for selection? (maybe to have be in Visual mode for this...)
" Delete all text on line, but keep line
" Go to first instance of searched text

" Insert Mode:
" COMMAND                                   STOCK           DESIRED
" Go to beginning of line                   ?               Ctrl+[command for "Start Insert mode: beginning of line"]
" Go to end of line                         ?               Ctrl+[command for "Start Insert mode: end of line"] 
"
" Command Or Insert Mode:
" COMMAND                                   STOCK           DESIRED
" Enter Visual [Generic] Mode               n/a             Shift...
"   ...Visual Mode                          v               ...h or l
"   ...Visual Line Mode                     Shift+v         ...whatever goes
"                                                           to beginning/end
"                                                           of line
"   ...Visual Block Mode                    Ctrl+v          ...j or k

" a = edit from beginning of line
" This inserts a space...annoying
" map a I 

" g = edit from end of line
" map g A

" Visual modes/text selection...
" nmap L v 
" ^ This is the right idea, but I have to let go of Shift after the first
" press of l. Better to be able to hold it down (i.e. nvim needs to ignore
" subsequent Shifts).

" PUT NEW REMAPS BELOW:

" SCOPE             KEY(S)          ACTION          

" change command invoker from : to space
nmap                <Space>         :

" Move line up              NOT WORKING
" nmap                <A-k>           :m-2<CR>

" Move line down            NOT WORKING
" nmap                <A-j>           :m+<CR>

" Page up                   NOT WORKING
nmap                <A-k>           <C-u>

" Page down                 NOT WORKING
nmap                <A-j>           <C-d>

" makes it so that up and down movement works more intuitively when navigating wrapped lines
map                 j               gj
map                 k               gk

" accelerated jk (https://github.com/rhysd/accelerated-jk)
nmap                j               <Plug>(accelerated_jk_gj_position)
nmap                k               <Plug>(accelerated_jk_gk_position)

" closes/opens NERDTree and moves focus
nnoremap <silent>   <Tab>           :NERDTreeToggle<CR>

" adds closing brackets; auto-indents into {} and []
" NOTE: this isn't working very well...disabling until I find a plugin that
" does auto-complete properly
" prepending Alt disables the macro and types only the single, left bracket
" inoremap            {               {}<Esc>i<CR><Esc>kA<CR><Tab>
" inoremap            [               []<Esc>i<CR><Esc>kA<CR><Tab>
" inoremap            (               ()<Esc>i
" inoremap            <A-{>           {
" inoremap            <A-[>           [
" inoremap            <A-(>           (   




