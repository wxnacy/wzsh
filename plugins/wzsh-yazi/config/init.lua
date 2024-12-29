-- plugins config
-- https://github.com/yazi-rs/plugins/tree/main/git.yazi
require("git"):setup()
-- https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi
require("smart-enter"):setup {
	open_multi = true,
}
-- https://github.com/yazi-rs/plugins/tree/main/full-border.yazi
require("full-border"):setup()
-- https://github.com/Rolv-Apneseth/starship.yazi?tab=readme-ov-file
require("starship"):setup()
-- https://github.com/h-hg/yamb.yazi
-- local bookmarks = {}
-- require("yamb"):setup {
  -- -- Optional, the path ending with path seperator represents folder.
  -- bookmarks = bookmarks,
  -- -- Optional, recieve notification everytime you jump.
  -- jump_notify = true,
  -- -- Optional, the cli of fzf.
  -- cli = "fzf",
  -- -- Optional, the path of bookmarks
  -- path = (os.getenv("HOME") .. "/Documents/Configs/wzsh/yazi/bookmarks"),
-- }
