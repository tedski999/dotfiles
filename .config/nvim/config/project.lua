local function config()
	require("project_nvim").setup({ show_hidden = true })
	require("telescope").load_extension("projects")
end

-- NOTE: consider nvim-telescope/telescope-project.nvim instead
return { "ahmedkhalf/project.nvim", after = "telescope.nvim", config = config }
