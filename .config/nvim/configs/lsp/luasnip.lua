
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

-- TODO: snippets
local function config()
	local luasnip = require("luasnip")

	vim.api.nvim_set_keymap("i", "<c-space>", "<cmd>lua LuasnipNext()<cr>", {noremap=true,silent=true})
	vim.api.nvim_set_keymap("s", "<c-space>", "<cmd>lua LuasnipNext()<cr>", {noremap=true,silent=true})
	-- vim.api.nvim_set_keymap("i", "<s-space>", "<cmd>lua LuasnipPrev()<cr>", {noremap=true,silent=true})
	-- vim.api.nvim_set_keymap("s", "<s-space>", "<cmd>lua LuasnipPrev()<cr>", {noremap=true,silent=true})

--[[
main
for
foreach
while
if
elseif
else
switch
trycatch
class

#ifndef
malloc
calloc
realloc
]]

	--local n = luasnip.snippet_node
	local t = luasnip.text_node
	local i = luasnip.insert_node
	--local f = luasnip.function_node
	--local c = luasnip.choice_node
	--local d = luasnip.dynamic_node

	luasnip.snippets = {

		c = {
			luasnip.snippet(
				{trig = "for (int i = 0; i < length; i++) {", namr = "Indexed for loop"},
				{t("for (int i = 0; i < "), i(1,"length"), t({"; i++) {",""}), i(0), t({"","}"})}
			),
			luasnip.snippet(
				{trig = "for (Type val = init; val; val++) {", namr = "For loop"},
				{t("for ("), i(1,"Type name = val"), t("; "), i(2,"val < limit"), t("; "), i(3,"increment"), t({") {",""}), i(0), t({"","}"})}
			),
			luasnip.snippet(
				{trig = "while (true) {", namr = "While loop"},
				{t("while ("), i(1,"cond"), t({") {",""}), i(0), t({"","}"})}
			),
			luasnip.snippet(
				{trig = "do { } while (true);", namr = "Do-while loop"},
				{t({"do {",""}), i(0), t({"","} while ("}), i(1,"cond"), t(");")}
			)
		}
	}

end

return { "L3MON4D3/LuaSnip", event = "VimEnter", config = config }
