local function config()
	vim.g.matchup_matchparen_offscreen = {method = "popup"}
	-- vim.cmd([[hightlight link MatchParen]])
end

return { "andymass/vim-matchup", config = config }
