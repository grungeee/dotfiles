-- This file was automatically created by the NvChad system package
-- to ensure NvChad starts correctly without errors.
--
-- You can add your custom lazy.nvim plugin specifications here.
-- For example:
-- return {
--   { "nvim-lua/plenary.nvim" },
--   -- add more plugins here
-- }
--
-- If you have no custom plugins yet, NvChad requires this file to return an empty table.
return {
  {
    "hat0uma/csvview.nvim",
    -- this runs the plugin's setup() for you
    ---@type CsvView.Options
    opts = {
      -- optional tweaks, you can leave this whole opts block out if you want defaults
      parser = {
        comments = { "#", "//" }, -- treat these as comment lines, they won't break the table
      },
      keymaps = {
        -- text objects for selecting a single cell
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },

        -- spreadsheet-style jumping:
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },

      -- you can also change how columns are shown:
      -- display_mode = "highlight", -- default: highlight separators
      -- display_mode = "border",    -- draws nice │ column borders instead
    },

    -- lazy-load on command (so it doesn't slow startup)
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
}
