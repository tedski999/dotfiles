local function config()

	function LuasnipNext()
		local luasnip = require("luasnip")
		if luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		end
	end

	function LuasnipPrev()
		local luasnip = require("luasnip")
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		end
	end

	--[[ TODO: snippets
	main for foreach while if elseif else switch trycatch class
	#ifndef malloc calloc realloc
	]]

end

return { "L3MON4D3/LuaSnip", config = config }
