local ls = require("luasnip")
local s = ls.s  -- snippet
local i = ls.i  -- insert node
local t = ls.t  -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- --

local snippets = {}
local autosnippets = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = true }
local group = augroup("Pandoc Snippets", { clear = true })

local function cs(trigger, nodes, keymap) --> cs stands for create snippet
	local snippet = s(trigger, nodes)
	table.insert(snippets, snippet)

	if keymap ~= nil then
		local pattern = "*.md"
		if type(keymap) == "table" then
			pattern = keymap[1]
			keymap = keymap[2]
		end
		autocmd("BufEnter", {
			pattern = pattern,
			group = group,
			callback = function()
				map({ "i" }, keymap, function()
					ls.snip_expand(snippet)
				end, opts)
			end,
		})
	end
end

local function lp(package_name) -- Load Package Function
	package.loaded[package_name] = nil
	return require(package_name)
end

-- Utility Functions --

-- Start Refactoring --

local newdoc = s(
    "newdoc",
    fmt(
        [[
---
documentclass: {}
classoption:
- oneside
title: {}
author: {}
date: {}
papersize: {}
geometry: {}
fontsize: {}
fontfamily: {}
newtxmathoptions:
-cmintegrals
-cmbraces
toc: {}
colorlinks: {}
linkcolor: {}
urlcolor: {}
---

        ]],
        {
            i(1, "article"),
            i(2, "Insert a Clever Title"),
            i(3, "Ralph Pengelly"),
            i(4, "\\today"),
            i(5, "a4"),
            i(6, "margin=2cm"),
            i(7, "12pt"),
            i(8, "palatino"),
            i(9, "false"),
            i(10, "true"),
            i(11, "RoyalBlue"),
            i(12, "RoyalBlue"),
        }
    )
)
-- local newdoc = s("newdoc", {
--     t("---"),
--     t({"", "documentclass: "}),
--     i(1, "article"),
--     t({"", "classoption: "}),
--     t({"", "- onside"}),
--     t({"", "title: "}),
--     i(2, "Insert a clever title"),
--     t({"", "author: "}),
--     i(3, "Ralph Pengelly"),
--     t({"", "date: "}),
--     i(4, "\\today"),
--     t({"", "papersize: "}),
--     i(5, "a4"),
--     t({"", "geometry: "}),
--     i(6, "margin=2cm"),
--     t({"", "fontsize: "}),
--     i(7, "12pt"),
--     t({"", "fontfamily: "}),
--     i(8, "palatino"),
--     t({"", "newtxmathoptions: "}),
--     t({"", "-cmintegrals"}),
--     t({"", "-cmbraces"}),
--     t({"", "toc: "}),
--     i(9, "false"),
--     t({"", "colorlinks: "}),
--     i(10, "true"),
--     t({"", "linkcolor: "}),
--     i(11, "RoyalBlue"),
--     t({"", "urlcolor: "}),
--     i(12, "RoyalBlue"),
--     t({"", "---", ""})
-- })
table.insert(snippets, newdoc)

-- End Refactoring --

return snippets, autosnippets
