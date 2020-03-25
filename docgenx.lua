-- docgenx.lua
-- automatically builds our documentation into /docs
-- written by Louka --> https://github.com/LoukaMB

local docgen = {}

function docgen.tree()
	local tree = {}
	tree.categories = {}
	return tree
end

function docgen.category(tree, name)
	tree.categories[name] = {}
	return tree.categories[name]
end

function docgen.method(f_return, f_name, f_arguments, f_description, f_example)
	local method = {}
	method.retn = f_return
	method.exam = f_example
	method.args = f_arguments
	method.desc = f_description
	method.name = f_name:gsub("%*prp%s*", "")
	method.proprietary = f_name:find("%*prp") and true
	return method
end

function docgen.entry(category, name, method)
	category[name] = method
end

function docgen.filestr(path)
	local io_f = io.open(path, "r")
	local f_str = io_f:read("*a")
	io_f:close()
	return f_str
end

function docgen.typename(str)
	return str:gsub("<", "<span class=\"CodeTypenameVariant\">&lt;"):gsub(">", "&gt;</span>")
end

function docgen.build(tree, prefix)
	local document = docgen.header
	local css = docgen.filestr("docstyle.css")
	local body = ""

	for cname, cval in pairs(tree.categories) do
		-- do something with categories. for now, not necessary
		body = body .. "<h1 class=\"CategoryTitle\">" .. cname .. "</h1>"
		for mname, mval in pairs(cval) do
			local methodargs = ""
			local bodyentry = docgen.entry
			if mval.args:len() ~= 0 then -- build argument list
				for argvt, argvn in mval.args:gmatch("([%w/<>]+) ([%w%.]+)") do
					methodargs = methodargs .. ("<span class=\"CodeTypename\">%s</span> %s, ")
					:format(docgen.typename(argvt), argvn)
				end
				methodargs = methodargs:gsub(",%s*$", "") -- erase extra comma
			else
				-- void argument list
				methodargs = "<span class=\"CodeTypename\">void</span>"
			end
			if mval.proprietary then
				bodyentry = bodyentry:format(mval.name:gsub("%*_", prefix), "CodeDefinitionProprietary", docgen.typename(mval.retn), '#' .. mval.name:gsub("%*_", prefix), mval.name:gsub("%*_", prefix), methodargs, mval.desc:gsub("%*_", prefix), mval.exam)
				body = body .. bodyentry
			else
				bodyentry = bodyentry:format(mval.name:gsub("%*_", prefix), "CodeDefinition", docgen.typename(mval.retn), '#' .. mval.name:gsub("%*_", prefix), mval.name:gsub("%*_", prefix), methodargs, mval.desc:gsub("%*_", prefix), mval.exam)
				body = body .. bodyentry
			end
		end
	end

	document = document:format(css, body)
	return document
end

function docgen.loadapidef(path)
	local f = io.open(path, "r")
	local a = f:read("*a")
	local fn, err = loadstring(a)
	if fn then
		f:close()
		return fn()
	else
		f:close()
		error("shit happened, please fix: " .. err)
	end
end

function docgen.main(path, prefix)
	assert(path, "path to api definition is missing")
	local prefix = prefix or "api."
	local api = docgen.loadapidef(path)
	local tree = docgen.tree()
	for k1, v1 in pairs(api) do
		local category = docgen.category(tree, k1)
		for k2, v2 in pairs(v1) do
			local f_retn, f_name, f_args, f_desc, f_ex = v2[1], v2[2], v2[3], v2[4], v2[5] or "No example provided"
			docgen.entry(category, f_name, docgen.method(f_retn, f_name, f_args, f_desc, f_ex))
		end
	end

	docgen.header = docgen.filestr("base_index.html")
	docgen.entry = docgen.filestr("base_entry.html")
	local document_string = docgen.build(tree, prefix)
	local out = io.open("docs/index.html", "w")
	out:write(document_string)
	out:close()
end

return docgen.main(...)