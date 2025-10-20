return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = opts.picker or {}
    opts.picker.hidden = true
    opts.picker.ignored = true -- This seems to mean "show ignored files" in this context

    -- For fuzzy finder (e.g., <leader><leader>)
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.files = opts.picker.sources.files or {}
    opts.picker.sources.files.hidden = true
  end,
}
