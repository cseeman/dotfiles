local vim = vim
local Plug = vim.fn['plug#']

-- Leader must be set before any mapping that references it.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Essential Neovim settings
vim.opt.mouse = 'a'                    -- Enable mouse
vim.opt.clipboard = 'unnamedplus'      -- Use system clipboard
vim.opt.ignorecase = true              -- Case insensitive search
vim.opt.smartcase = true               -- Case sensitive when uppercase
vim.opt.incsearch = true               -- Incremental search
vim.opt.hlsearch = true                -- Highlight search results
vim.opt.expandtab = true               -- Use spaces instead of tabs
vim.opt.tabstop = 2                    -- Tab width
vim.opt.shiftwidth = 2                 -- Indent width
vim.opt.softtabstop = 2                -- Soft tab width
vim.opt.autoindent = true              -- Auto indent
vim.opt.smartindent = true             -- Smart indent
vim.opt.wrap = false                   -- No line wrapping
vim.opt.scrolloff = 8                  -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8              -- Keep 8 columns left/right of cursor
vim.opt.termguicolors = true           -- Enable true colors
vim.opt.showmode = false               -- Don't show mode in cmd line (handled by statusline)
vim.opt.completeopt = 'menuone,noselect' -- Better completion
vim.opt.updatetime = 300               -- Faster completion
vim.opt.timeoutlen = 300               -- Faster key sequence completion

vim.call('plug#begin')
-- Shorthand notation for GitHub; translates to https://github.com/junegunn/seoul256.vim.git
-- Plug('junegunn/seoul256.vim')
Plug('nvim-tree/nvim-web-devicons')
-- Any valid git URL is allowed
Plug('https://github.com/junegunn/vim-easy-align.git')

-- Adding Rails specific VIM plugins
Plug('https://tpope.io/vim/dispatch.git')
Plug('https://github.com/tpope/vim-bundler')
Plug('https://github.com/tpope/vim-rails')

-- fzf.vim needs the base plugin that ships with Homebrew's fzf.
vim.opt.rtp:append('/opt/homebrew/opt/fzf')
Plug('junegunn/fzf.vim')

-- Gruvbox Theme - making it pretty
Plug 'ellisonleao/gruvbox.nvim'

-- Adding a colorize type plugin, to see if I can see the color of hexcodes by the codes
Plug('rrethy/vim-hexokinase', { ['do'] = 'make hexokinase' })

-- If the vim plugin is in a subdirectory, use 'rtp' option to specify its path
-- Plug('nsf/gocode', { ['rtp'] = 'vim' })

-- On-demand loading: loaded when the specified command is executed
-- Plug('preservim/nerdtree', { ['on'] = 'NERDTreeToggle' })

-- On-demand loading: loaded when a file with a specific file type is opened
-- Plug('tpope/vim-fireplace', { ['for'] = 'clojure' })

vim.call('plug#end')

-- switch-theme.sh writes "light" or "dark" here when the tmux theme changes.
local function theme_mode()
    local f = io.open(vim.fn.expand('~/.config/theme-mode'))
    if not f then return 'dark' end
    local mode = f:read('*l')
    f:close()
    return mode == 'light' and 'light' or 'dark'
end
vim.o.background = theme_mode()

-- Safe color scheme loading
local status_ok, gruvbox = pcall(require, "gruvbox")
if status_ok then
    gruvbox.setup({
        palette_overrides = {
            bright_green = "#98971A",
        },
        transparent_mode = false,
        overrides = {
            -- Custom overrides if needed
        }
    })
    vim.cmd("colorscheme gruvbox")
else
    -- Fallback to a built-in color scheme
    vim.cmd("colorscheme desert")
    print("Gruvbox not found, using fallback colorscheme")
end

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Git commit message settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.wo.colorcolumn = "50,72"
        vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })
    end
})

-- FZF configuration
vim.g.fzf_layout = { down = '~40%' }
vim.g.fzf_preview_window = { 'right:50%', 'ctrl-/' }
vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-s'] = 'split',
    ['ctrl-v'] = 'vsplit'
}

-- Key mappings for FZF. Buffers and grep sit under leader so C-b and C-f keep
-- paging.
vim.keymap.set('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g>', ':GFiles<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', ':Buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', ':Rg<CR>', { noremap = true, silent = true })

-- General key mappings
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { noremap = true, silent = true })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

-- Clear search highlighting
vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>', { noremap = true, silent = true })
