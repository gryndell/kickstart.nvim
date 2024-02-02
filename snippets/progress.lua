local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.p"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --

local defbuf = s(
    "defbuf",
    fmt(
[[
define buffer b_{1} for {2}.
]],
    {
        i(1, "tablename"),
        rep(1),
    }
    )
)
table.insert(snippets, defbuf)

local defvar = s(
    "defvar",
    fmt(
[[
define variable {1} as {2} no-undo.
]],
    {
        i(1, "varname"),
        c(2, {t("integer"), t("decimal"), t("logical"), t("character")}),
    }
    )
)
table.insert(snippets, defvar)

local ff = s(
    "ff",
    fmt(
        [[
find first {1} {2} where
{4}.{3}
        ]],
    {
        i(1, "buffername"),
        i(2, "no-lock"),
        i(3, "fieldname"),
        rep(1),
    }
    )
)
table.insert(snippets, ff)

local fl = s(
    "fl",
    fmt(
        [[
find last {1} {2} where
{4}.{3} no-error.
        ]],
    {
        i(1, "buffername"),
        i(2, "no-lock"),
        i(3, "fieldname"),
        rep(1),
    }
    )
)
table.insert(snippets, fl)

local progproc = s(
    "proc",
    fmt(
[[
procedure {1}:
    define  input parameter {2} as {3}.
    define output parameter {4} as {5} initial {6} no-undo.
    define output parameter {7} as {8} initial {9} no-undo.

    {10}
end procedure. /* {11} */
]],
    {
        i(1, "procname"),
        i(2, "s_inp_par1"),
        c(3, {t("integer"), t("decimal"), t("logical"), t("character")}),
        i(4, "s_out_par1"),
        i(5, "logical"),
        i(6, "no"),
        i(7, "s_out_par2"),
        i(8, "character"),
        i(9, "''"),
        i(10, ""),
        rep(1),
    }
    )
)
table.insert(snippets, progproc)

 local progfunc = s(
     "func",
     fmt(
[[
/** {1} **/
function {2} returns {3}
(
    {4} as {5}
):
    define variable {6} as {7} initial {8} no-undo.
    {9}
    return {10}
end function. /* {11} */
]],
     {
         i(1, "description"),
         i(2, "func_name"),
         i(3, "character"),
         i(4, "f_inp_var"),
         i(5, "date"),
         i(6, "f_out_var"),
         i(7, "character"),
         i(8, "''"),
         i(9, ""),
         rep(6),
         rep(2),
     }
     )
 )
 table.insert(snippets, progfunc)

local progon = s(
    "on",
    fmt(
[[
on {1} of {2} in frame {3} do:
    {4}
end. /** {5} of {6} in frame {7} **/
]],
    {
        i(1, "f1, pf1, go, 'enter'"),
        i(2, "fieldname"),
        i(3, "framename"),
        i(4, ""),
        rep(1),
        rep(2),
        rep(3),
    }
    )
)
table.insert(snippets, progon)

-- End Refactoring --

return snippets, autosnippets
