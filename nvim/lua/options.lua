require "nvchad.options"

-- ========================< USER CONFIGS >=========================

--------------------------------------------------------------------
local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!



--------------------------------------------------------------------
-- >>> "GOD THANK YOU FINALLY I AM FREE OF THIS BULLSHIT SETTINGS" <<<

--> Disables commetnt expension on `o` and `O`
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=o"
})
--< [init.vim] 
-- autocmd FileType * setlocal formatoptions-=o
--------------------------------------------------------------------


--
-- set exrc
--
o.smartindent = true --                     Makes indenting smart
-- set expandtab                           " Converts tabs to spaces
o.splitbelow = true --                      Horizontal splits will automatically be below
-- set splitright                          " Vertical splits will automatically be to the right
o.splitright = true
-- set nobackup                            " This is recommended by coc
o.backup = false
-- set nowritebackup                       " This is recommended by coc
o.writebackup = false
-- set updatetime=300                      " Faster completion
o.updatetime = 300
-- set cursorline                          " Enable highlighting of the current line
o.cursorline = true
-- set cmdheight=2                         " More space for displaying messages
o.cmdheight = 2
-- set number relativenumber               " Relative line numbers + cur lin  number
o.relativenumber = true
-- set formatoptions-=cro                  " Stop newline continution of comments
o.formatoptions = "cro"
-- set clipboard=unnamedplus               " Copy paste between vim and everything else
-- o.clipboard = "unnamedplus"
-- set showtabline=2                       " Always show tabs
-- set nowrap                              " Display long lines as just one line
o.wrap = true
-- set scrolloff=8                         " starts to scroll 8 lines earlier
o.scrolloff = 28 -- centers the cursorline
-- set signcolumn=yes                      " Signcolum for git & error visualiztation
-- set noshowmode                          " We don't need to see things like -- INSERT -- anymore
o.showmode = false
-- set pumheight=10                        " Makes popup menu smaller
o.pumheight = 10
-- set updatetime=300                      " Faster completion
-- " set timeoutlen=500                      " By default timeoutlen is 1000 ms
-- set iskeyword+=-                        " treat dash separated words as a word text object"

-- syntax on
o.syntax = "on"
-- set ruler
o.ruler = true
-- let no_buffers_menu=1
-- set tabstop=4
o.tabstop = 2
-- set shiftwidth=4
o.shiftwidth = 2
-- set softtabstop=0
o.softtabstop = 0
-- set expandtab
o.expandtab = true
-- set backspace=indent,eol,start
o.backspace = "indent,eol,start"
-- set mouse=a
-- set signcolumn=yes
o.signcolumn = "yes"
-- set cmdheight=2
o.swapfile = false -- disable this cuz swap is annoying and brakees stuff plus i made autosave and pres undo
--
-- -------------- Searching
-- set ignorecase
o.ignorecase = true
-- set hlsearch
-- set incsearch
-- set smartcase
--
--------------------- Autosave
vim.cmd([[
  augroup AutoSave
    autocmd!
    autocmd InsertLeave,TextChanged * silent! wall
  augroup END
]]) 

--------------- Disable automatic comment continuation on new line
-- Disable automatic comment continuation globally
-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = '*',
--   callback = function()
--     vim.opt.formatoptions:remove('c')
--     vim.opt.formatoptions:remove('r')
--     vim.opt.formatoptions:remove('o')
--   end,
-- })
--
-- Function to disable comment continuation
local function disable_comment_continuation()
  vim.opt.formatoptions = vim.opt.formatoptions
    - 'c'  -- Remove auto-wrap of comments
    - 'r'  -- Remove continuation of comments with Enter
    - 'o'  -- Remove continuation of comments with 'o' or 'O'
end

-- Apply the function on VimEnter to ensure it's set globally
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = disable_comment_continuation,
})

-- Apply the function on BufEnter to ensure it works for new buffers
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = disable_comment_continuation,
})

--------------- Enable persistent undo
-- Increase the undo memory
o.undolevels = 10000 -- Sets the maximum number of changes that can be undone
o.undoreload = 10000 -- Sets the maximum number of lines to save for undo
o.undofile = true -- Enable persistent undo
o.undodir = vim.fn.expand('~/.config/nvim/undodir') -- Set the undo directory

