
-- DCL API dictionary, formatted for Lua scripts
-- Last update: October 24, 2019

return
{
	["Environment Library"] =
	{
		{ "table", "*_getgenv", "", "Returns the environment that will be applied to each script ran by Synapse." };
		{ "table", "*_getrenv", "", "Returns the global thread environment for the LocalScript context." };
		{ "variant<table/nil>", "*_getsenv", "object<LocalScript/ModuleScript> Script", "Returns Script's environments. Returns nil if Script isn't running."};
		{ "table", "*_getreg", "", "Returns the Lua registry." };
		{ "table", "*_getgc", "", "Returns the Lua GC list. This can very easily leak memory if not used correctly." };
		{ "table<object>", "*_getinstances", "", "Returns a list of all instances within the game." };
		{ "table<BaseScript>", "*_getnilinstances", "", "Returns a list of all instances parented to nil within the game." };
		{ "table<BaseScript>", "*_getscripts", "", "Returns a list of all scripts within the game." };
		{ "table<BaseScript>", "*_getrunningscripts", "", "Returns a list of all running scripts." };
		{ "table<ModuleScript>", "*_getloadedmodules", "", "Returns a list of all ModuleScripts within the game." };
		{ "variant<LocalScript/ModuleScript/nil>", "*_getcallingscript", "", "Returns the script calling the current function." };
	};

	["Signal Library"] =
	{
		{ "table", "*_getconnections", "", "Returns a list of all connections within the game." };
		{ "void", "*_fireclickdetector", "object<ClickDetector> ClickDetector, <number/nil> Distance", "Fires the designated ClickDetector with distance provided. If distance isn't provided, it will default to 0." };
		{ "void", "*_firetouchinterest", "object<Part> Part, object<TouchTransmitter> Transmitter, number Toggle", "Fires the designated TouchTransmitter with Part. The Toggle argument is used to tell whether the Part is currently being touched." };
	};

	["Context Library"] =
	{
		{ "void", "*_context_set", "int Context", "Sets the current thread context to Context." };
		{ "int", "*_context_get", "", "Returns the current thread context as an integer." };
	};

	["Table Extensions"] =
	{
		{ "variant<table/nil>", "getrawmetatable", "variant<table/userdata> Value", "Retrieves the metatable of value if it exists, or return nil." };
		{ "void", "table.lock", "table T", "Locks T, preventing modifications." };
		{ "void", "table.unlock", "table T", "Unlocks T, allowing modifications." };
		{ "bool", "table.islock", "table T", "Returns true or false depending if T is locked or not." };
	};

	["Keyboard/Mouse Library"] =
	{
		{ "bool", "*_isactive", "", "Returns true if the user is focused on the game window." };
		{ "void", "*_keypress", "int Keycode", 'Simulates a keypress for the specified keycode. For more information, <a href="https://docs.microsoft.com/en-us/windows/desktop/inputdev/virtual-key-codes" target="_blank">click here.</a>'};
		{ "void", "*_keyrelease", "int Keycode", "Simulates a key release for the specified keycode." };
		{ "void", "*_mouse1click", "", "Simulates a full left mouse button press and release." };
		{ "void", "*_mouse1press", "", "Simulates a left mouse button press." };
		{ "void", "*_mouse1release", "", "Simulates a left mouse button release." };
		{ "void", "*_mouse2click", "", "Simulates a full right mouse button press and release." };
		{ "void", "*_mouse2press", "", "Simulates a right mouse button press." };
		{ "void", "*_mouse2release", "", "Simulates a right mouse button release." };
		{ "void", "*_mousescroll", "int Pixels", "Scrolls the mouse wheel virtually by Pixels pixels." };
		{ "void", "*_mousemoverel", "int X, int Y", "Moves the mouse cursor relatively by the specified coordinates." };
	};

	["Clipboard Library"] =
	{
		{ "void", "*_clipboard_set", "string Content", "Set the system's clipboard to Content" };
		{ "string", "*_clipboard_get", "", "Return the clipboard's content" };
	};

	["Hooking Library"] =
	{
		{ "function", "*_hookfunction", "function Target, function Hook", "Hooks Target and replaces it with Hook. Returns the unhooked function." };
		{ "function", "*_newcclosure", "function Fn", "Pushes a CClosure that invokes Fn. Used for metatable hooks." };
	};

	["IO Library"] =
	{
		{ "string", "*_io_read", "string Filepath", "Reads the contents at filepath Filepath and returns it as an ASCII string." };
		{ "void", "*_io_write", "string Filepath, string Data", "Writes Data at Filepath and creates the file if it doesn't exist." };
		{ "void", "*_io_append", "string Filepath, string Data", "Appends Data to the file located at Filepath." };
		{ "table<string>", "*_io_listdir", "string Filedir", "Returns a table containing a directory's files." };
		{ "bool", "*prp *_io_isfile", "string Filepath", "Returns whether the file at Filepath is a file." };
		{ "bool", "*prp *_io_isfolder", "string Filepath", "Returns whether the file at Filepath is a directory." };
		{ "void", "*prp *_io_delfile", "string Filepath", "Deletes the file at Filepath." };
		{ "void", "*prp *_io_delfolder", "string Filepath", "Deletes the directory at Filepath." };
	};

	["Console Library"] =
	{
		{ "void", "*prp *_console_name", "string Name", "Set the currently allocated console's title to Name." };
		{ "string", "*prp *_console_input", "", "Yields the Engine and returns the user's input." };
		{ "string", "*prp *_console_input_async", "", "Yields the current thread and returns the user's input." };
		{ "void", "*prp *_console_print", "string Arg", "Prints Arg to the allocated console." };
		{ "void", "*prp *_console_iprint", "string Arg", "Akin to *_console_print but prefixes Arg with [INFO]. Mainly used by internal scripts for debugging purposes." };
		{ "void", "*prp *_console_wprint", "string Arg", "Akin to *_console_print but prefixes Arg with [WARN]. Mainly used by internal scripts for debugging purposes." };
		{ "void", "*prp *_console_eprint", "string Arg", "Akin to *_console_print but prefixes Arg with [ERR]. Mainly used by internal scripts for debugging purposes." };
	};

	["Reflection and Engine Library"] =
	{
		{ "bool", "*_checkcaller", "", "Returns true if the current thread is owned by Synapse X. " };
		{ "bool", "*_islclosure", "function Fn", "Returns true if Fn is a Lua function." };
		{ "string", "*prp *_dumpstring", "string Script", "Dumps the bytecode for the Script chunk." };
		{ "string", "*prp *_decompile", "variant<function, LocalScript, ModuleScript> Script, bool Bytecode", "Decompiles Script and returns the decompiled script, or its bytecode if Bytecode is true." };
		{ "void", "*prp *_obj_override", "object Object, string PropertyName, any Value", "Overrides field PropertyName in Object to Value and prevents its replication." };
		{ "table", "*prp *_obj_specialinfo", "object Object", "Returns a list of special properties for certain instances, such as MeshParts, UnionOperations or Terrain." };
		{ "void", "*_obj_save", "table Flags", "Saves the current game to your workspace folder. Flags is a table containing two fields: noscripts, a boolean specifying whether scripts are to be decompiled automatically, and mode, which is a string that sets the serialization mode." };
		{ "object<WebSocket>", "*prp *_net_websocket", "string Name", "Opens the Synapse Websocket with channel Name. This function will be absent if WebSocket support is disabled in theme.json" };
	};

	["Encryption Library"] =
	{
		{ "string", "*prp *_crypt_encrypt", "string Data, string Key", "Encrypts Data with Key and returns it." };
		{ "string", "*prp *_crypt_decrypt", "string Data, string Key", "Decrypts Data with Key and returns it." };
		{ "string", "*prp *_crypt_b64_encode", "string Data", "Encodes Data in base64." };
		{ "string", "*prp *_crypt_b64_decode", "string Data", "Decodes Data from base64." };
		{ "string", "*prp *_crypt_hash", "string Data", "Returns Data's hash." }; 
	};
}