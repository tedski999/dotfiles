local function config()
	vim.g.matchup_matchparen_offscreen = {method = "popup"}
end

return { "andymass/vim-matchup", config = config }
