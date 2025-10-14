-- wiki-helper/init.lua
-- Offline Wiki Search + Hover for Neovim
-- by Athul Subash

local M = {}

-- === CONFIGURATION ===
M.config = {
  wikis = {
    hypr = "~/Documents/wikis/hyprland/content/",
    -- nvim = "~/Documents/nvim-wiki",
    -- waybar = "~/Documents/waybar-wiki",
  },
  mappings = {
    hypr = { pattern = "hypr", filetypes = { "hyprlang" } },
    nvim = { pattern = "nvim", filetypes = { "lua" } },
    waybar = { pattern = "waybar", filetypes = { "json" } },
  },
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- Commands
  vim.api.nvim_create_user_command("WikiSearch", M.search, {})
  -- Keymaps
  vim.keymap.set("n", "<leader>ws", M.search, { desc = "Search current wiki" })
  vim.keymap.set("n", "K", M.hover, { desc = "Wiki hover" })
end

-- === UTILS ===
local function get_current_wiki()
  local bufpath = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype
  for name, map in pairs(M.config.mappings) do
    if
      (map.filetypes and vim.tbl_contains(map.filetypes, filetype))
      or (map.pattern and bufpath:match(map.pattern))
    then
      return vim.fn.expand(M.config.wikis[name]), name
    end
  end
  return nil
end

-- === SEARCH FUNCTION ===
function M.search()
  local wiki, name = get_current_wiki()
  if not wiki then
    vim.notify("No wiki configured for this file", vim.log.levels.WARN)
    return
  end

  require("telescope.builtin").live_grep({
    cwd = wiki,
    prompt_title = "Search " .. name .. " Wiki",
  })
end

-- === HOVER FUNCTION ===
function M.hover()
  local wiki = get_current_wiki()
  if not wiki then
    vim.notify("No wiki configured for this file", vim.log.levels.WARN)
    return
  end

  local word = vim.fn.expand("<cword>")
  local output = vim.fn.systemlist({ "rg", "-A3", "-B1", "--no-heading", word, wiki })

  if vim.tbl_isempty(output) then
    vim.notify("No match for '" .. word .. "'", vim.log.levels.INFO)
    return
  end

  vim.lsp.util.open_floating_preview(output, "markdown", { border = "rounded" })
end

return M
