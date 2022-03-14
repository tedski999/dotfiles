local function config()
	vim.g.smoothie_speed_constant_factor = 25
	vim.g.smoothie_speed_linear_factor = 25
	vim.g.smoothie_speed_exponentiation_factor = 0.9
end

return { "psliwka/vim-smoothie", config = config }
