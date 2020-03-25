-- Synapse X-Sanctioned Development Compatibility Layer (DCL)
-- https://github.com/LoukaMB/SynapseX/script/compatibility_layer.lua
-- Usage: loadstring(game:HttpGet("https://raw.githubusercontent.com/LoukaMB/SynapseX/master/script/compatibility_layer.lua"))()

-- This script provides a standardized API for Lua scripts with environment extensions.
-- Definitions are written in corcondance with https://loukamb.github.io/SynapseX/
-- (Functions start with api.* instead of syn_)

-- Last Update: October 22, 2019

--[[
		COMPATIBILITY PERCENTAGES (estimates)
		Synapse X (post-Holiday update): 100%
		Synapse X (pre-Holiday update): 98%
		Calamari:	95%
		ProtoSmh:	75%
		Elysian:	50%
		SirHurt:	?

		DOCUMENTATION SOURCES (to be updated regularly)
		Calamari:	/compatibility_layer_docs/calamari_docs.html
		ProtoSm.:	/compatibility_layer_docs/ps_docs.html
		Elysian:	/compatibility_layer_docs/elysian_docs.html
		Synapse:	https://loukamb.github.io/SynapseX/
		SirHurt:	?

		DISCLAIMER
		This script is offered FREE OF CHARGE by the folks at Synapse GP. You can use this for
		ANYTHING and I (Louka) don't really care but it'd be nice if you kept this disclaimer or
		something (and a link to my website) so people know who wrote most of it <3

		DISCLAIMER #2
		The main reason why I decided to write this is because of the many API changes in the
		Synapse X Holiday update, which changes (almost) every single definition out here. I
		doubt other exploits will immediately rush to implement Synapse X compatibility so this
		should come in handy. Also, this should solve most of your cross-compatibility problems
		and many "or X or Y or Z" statements :P

		DISCLAIMER #3
		This is supposed to work with most exploits out here, but things may break if you run some
		private thing or your exploit goes lengths to break this script (which it shouldn't because
		this is for compatibility and supporting this is 100% GREAT FOR SCRIPT DEVELOPERS!), so if
		something doesn't work just open an issue case on the GitHub or something thank you
--]]

--[[ macalamari funcs: (according to https://v3rmillion.net/showthread.php?tid=897918)
loadstring
game:GetObjects
game:HttpGet
writefile
readfile
getrawmetatable
setreadonly
getnamecallmethod
make_writeable
newcclosure
]]

local function flag_to_name(software_flag)
	return
	({

		["unk"]			= "Unknown exploit";
		["ps"]			= "ProtoSmasher";
		["synx"]		= "Synapse X";
		["synx_old"]	= "Synapse X (pre-Holiday update)";
		["sh"]			= "SirHurt";
		["cl"]			= "Calamari (Windows)";
		["clx"]			= "Calamari (macOS)";
		["ely"]			= "Elysian";

	})[software_flag]
end

local function unsupported(feature, flag)
	return function() error(("api::%s is not supported by %s"):format(feature, flag_to_name(flag))) end
end

local function idxparse(src_table, statement)
	local current_kv
	for key in statement:gmatch("([^%.]+)") do
		if not current_kv then
			current_kv = src_table[key]
		else
			current_kv = current_kv[key]
			if current_kv == nil then
				return -- cannot parse any further
			end
		end
	end
	return current_kv
end

local function lookup(src_table, ...)
	local alias_list = {...}
	for k, v in pairs(src_table) do
		local s, tv = pcall(idxparse, src_table, v)
		if s and tv then
			return tv
		end
	end
	return -- not existing
end

local prev_global
local function globals() -- look up prefered global table
	if prev_global then
		return prev_global
	end
	-- getgenv is pretty much universal
	local a, b, c = _G, getfenv(), getgenv()
	local lookupk = "_VERSION"
	-- in order of preference
	if c[lookupk] then
		-- prefered
		if not prev_global then
			prev_global = a
		end
		return a
	elseif b[lookupk] then
		-- should only be the case in minimal exploits
		if not prev_global then
			prev_global = b
		end
		return b
	elseif a[lookupk] then
		-- should only be the case in lua wrappers
		if not prev_global then
			prev_global = c
		end
		return c
	end
end 

return function()
	local api = {}
	local flags = {}

	do -- Calculate Flags
		if pebc_load then										-- is ProtoSmasher
			flags.software = "ps"
		end

		if not flags.software and getnspval then				-- is Elysian
			flags.software = "ely"
		end

		if not flags.software and writefileas then				-- is Calamari
			flags.software = "cl"
		end

		if not flags.software and syn or syn_context_get then	-- is Synapse X (unknown version)
			if syn_context_get then								-- is Synapse X (post Holiday update)
				flags.software = "synx"
			else												-- is Synapse X (pre Holiday update)
				flags.software = "synx_old"
			end
		end

		if not flags.software and make_writeable then			-- is Calamari (macOS)
			-- note to calamri devs: if you want a more accurate way of
			-- detecting whether your software is its mac os version please
			-- include some sort of constant or something
			flags.software = "clx"
		end

		if not flags.software then
			flags.software = "unk"								-- Unknown exploit
		end
	end

	do -- Create Clipboard Library
		if flags.software == "synx" then
			api.clipboard_get = syn_clipboard_get
			api.clipboard_set = syn_clipboard_set
		elseif flags.software == "cl" then
			api.clipboard_get = getclipboard
			api.clipboard_set = setclipboard
		elseif flags.software == "ely" then
			api.clipboard_get = unsupported("clipboard_get", flags.software)
			api.clipboard_set = Clipboard.set
		elseif flags.software == "synx_old" or flags.software == "ps" then
			api.clipboard_get = unsupported("clipboard_get", flags.software)
			api.clipboard_set = setclipboard
		else
			local globals = globals()
			api.clipboard_get = lookup(globals, "getclipboard", "get_clipboard", "Clipboard.get")
								or unsupported("clipboard_get", flags.software)
			api.clipboard_set = lookup(globals, "setclipboard", "set_clipboard", "Clipboard.set")
								or unsupported("clipboard_set", flags.software)
		end
	end

	do -- Create Environment Functions
		if flags.software == "synx" then
			api.getgenv = syn_getgenv
			api.getrenv = syn_getrenv
			api.getsenv = syn_getsenv
			api.getreg = syn_getreg
			api.getgc = syn_getgc
			api.getinstances = syn_getinstances
			api.getnilinstances = syn_getnilinstances
			api.getloadedmodules = syn_getloadedmodules
			api.getconnections = syn_getconnections -- NOTE: unsure if fixed on post Holiday
			api.getscripts = syn_getscripts
			api.getcallingscript = syn_getcallingscript
		elseif flags.software == "synx_old" then
			api.getgenv = getgenv
			api.getrenv = getrenv
			api.getsenv = getsenv
			api.getreg = getreg
			api.getgc = getgc
			api.getinstances = getinstances
			api.getnilinstances = getnilinstances
			api.getscripts = getscripts
			api.getloadedmodules = getloadedmodules
			api.getconnections = getconnections -- broken afaik, load anyway just in case
		elseif flags.software == "ps" then
			api.getgenv = getgenv
			api.getrenv = getrenv
			api.getsenv = getsenv
			api.getreg = getregistry
			api.getgc = get_gc_objects
			api.getinstances = unsupported("getinstances", flags.software)
			api.getnilinstances = get_nil_instances
			api.getloadedmodules = get_loaded_modules
			api.getconnections = get_signal_connections -- unsure if still unimplemented, not on api list
									or unsupported("getconnections", flags.software)
			function api.getscripts()
				-- manually reimplement
				local rest = {}
				local scre = getscriptenvs()
				for k, _ in next, scre do
					rest[#rest + 1] = k
				end
				return rest
			end
		elseif flags.software == "ely" then
			api.getgenv = getgenv
			api.getrenv = getrenv
			api.getsenv = getsenv
			api.getreg = getreg
			api.getgc = getgc
			api.getinstances = getinstances
			api.getnilinstances = getnilinstances
			api.getscripts = unsupported("getscripts", flags.software) -- reimpl using getinstances would be too performance heavy
			api.getloadedmodules = unsupported("getloadedmodules", flags.software) -- ditto
			api.getconnections = getconnections
		elseif flags.software == "cl" then
			api.getgenv = getgenv
			api.getrenv = getrenv
			api.getsenv = getsenv
			api.getreg = getreg
			api.getgc = getgc
			api.getinstances = getinstances
			api.getnilinstances = getnilinstances
			api.getscripts = getscripts
			api.getloadedmodules = unsupported("getloadedmodules", flags.software)
			api.getconnections = unsupported("getconnections", flags.software)
		else
			local globals = globals()
			api.getgenv = lookup(globals, "getgenv", "get_genv") or unsupported("getgenv", flags.software)
			api.getrenv = lookup(globals, "getrenv", "get_renv") or unsupported("getrenv", flags.software)
			api.getsenv = lookup(globals, "getsenv", "get_senv") or unsupported("getsenv", flags.software)
			api.getreg = lookup(globals, "getreg", "getregistry", "get_registry") or unsupported("getreg", flags.software)
			api.getgc = lookup(globals, "getgc", "get_gc", "gclist") or unsupported("getgc", flags.software)
			api.getinstances = lookup(globals, "getinstances", "get_instances", "get_instance_list") or unsupported("getinstances", flags.software)
		end
	end

	do -- Create Context library
		if flags.software == "synx" then
			api.context_get = syn_context_get
			api.context_set = syn_context_set
		elseif flags.software == "synx_old" then
			api.context_get = syn.get_thread_identity
			api.context_get = syn.set_thread_identity
		elseif flags.software == "ps" then
			api.context_get = get_thread_context
			api.context_set = unsupported("context_set", flags.software)
		elseif flags.software == "ely" then
			api.context_get = unsupported("context_get", flags.software)
			api.context_set = unsupported("context_set", flags.software)
		elseif flags.software == "cl" then
			api.context_get = getcontext
			api.context_set = setcontext
		else
			api.context_get = lookup(globals(), )
		end
	end

	do -- Create IO library
		if flags.software == "synx" then
			api.io_write = syn_io_write
			api.io_read = syn_io_read
			api.io_append = syn_io_append
		elseif flags.software == "synx_old" then
			api.io_write = writefile
			api.io_read = readfile
			api.io_append = appendfile
		elseif 
	end

	return api
end