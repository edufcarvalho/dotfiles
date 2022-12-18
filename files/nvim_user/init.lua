--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key

local config = {
  mappings = {
    i = {
      ["<C-z>"] = { "<C-o>:u<CR>"}, -- undo file
      ["<C-r>"] = { "<C-o><C-r>" }, -- redo file
      ["<C-q>"] = { "<C-o>:q!<CR>" }, -- quit current window
      ["<C-s>"] = { "<C-o>:up<CR>" }, -- save file
    },
    v = {
      ["<C-c>"] = { "\"+y" }, -- copy selected text
      ["<C-q>"] = { ":q!<CR>" }, -- quit current window
      ["<C-z>"] = { "<Nop>" }, -- ignore suspend
    },
    n = {
      ["<C-z>"] = { "<Nop>" }, -- ignore suspend
    }
  },

  lsp = {
    formatting = {
      format_on_save = false,
    },
  },

  plugins = {
    init = {
      -- enable endwise
      ["RRethy/nvim-treesitter-endwise"] = {
        require('nvim-treesitter.configs').setup({
          endwise = {
            enable = true,
          },
        })
      },
    },
  },

  polish = function()
    vim.api.nvim_set_option("clipboard", "unnamed") -- make copy and paste work correctly
  end
}

return config
