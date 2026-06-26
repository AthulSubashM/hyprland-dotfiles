-- Helper function to fetch and clean Pywal hex codes
local function get_wal_colors()
  local wal_cache = vim.fn.expand("~/.cache/wal/colors.lua")
  if vim.fn.filereadable(wal_cache) == 1 then
    package.loaded[wal_cache] = nil
    local wal = dofile(wal_cache)
    
    local function clean_color(color_val)
      local hex = string.format("%x", color_val)
      if #hex == 8 then return "#" .. hex:sub(3) end
      return "#" .. hex
    end

    return {
      bg     = clean_color(wal.background),
      fg     = clean_color(wal.foreground),
      black  = clean_color(wal.color0),
      red    = clean_color(wal.color1),
      green  = clean_color(wal.color2),
      yellow = clean_color(wal.color3),
      blue   = clean_color(wal.color4),
      magenta= clean_color(wal.color5),
      cyan   = clean_color(wal.color6),
      white  = clean_color(wal.color7),
      comment= clean_color(wal.color8),
    }
  end
  return nil
end

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm", -- Using storm as our base layout vehicle
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      -- This is where the magic happens: we hijack Tokyo Night's internal color palette variables
      on_colors = function(colors)
        local wal = get_wal_colors()
        if not wal then return end

        -- Inject your wallpaper hex codes directly into Tokyo Night's core engine variables
        colors.bg = wal.bg
        colors.bg_dark = wal.bg
        colors.bg_float = wal.bg
        colors.bg_sidebar = wal.bg
        colors.bg_statusline = wal.bg
        colors.fg = wal.fg
        colors.fg_dark = wal.fg
        colors.fg_sidebar = wal.fg
        
        -- Map standard terminal color spectrums out to the engine layers
        colors.black = wal.black
        colors.comment = wal.comment
        colors.red = wal.red
        colors.green = wal.green
        colors.yellow = wal.yellow
        colors.blue = wal.blue
        colors.magenta = wal.magenta
        colors.cyan = wal.cyan
        colors.white = wal.white
        
        -- Re-index specific target components so UI edges match up flawlessly
        colors.border = wal.blue
        colors.border_highlight = wal.magenta
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Force LazyVim to load our modified Tokyo Night build as the master layout
      opts.colorscheme = "tokyonight"

      -- Expose a clean reloading trigger to the system environment
      vim.api.nvim_create_user_command("PywalReload", function()
        -- 1. Wipe Tokyo Night's compiled cache files so it reads the fresh overrides
        pcall(function()
          local cache_path = vim.fn.stdpath("cache") .. "/tokyonight_storm.json"
          vim.fn.delete(cache_path)
        end)
        
        -- 2. Force a hard system reload of the colorscheme framework
        vim.cmd("colorscheme tokyonight")
        vim.cmd("redraw!")
      end, {})
    end,
  },
}
