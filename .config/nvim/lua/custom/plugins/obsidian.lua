return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    "BufReadPre /home/Desktop/school/**.md",
    "BufNewFile /home/Desktop/school/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "school",
        path = "home/Desktop/school/",
      },
      -- {
      --   name = "work",
      --   path = "~/vaults/work",
      -- },
    },

  },
}
