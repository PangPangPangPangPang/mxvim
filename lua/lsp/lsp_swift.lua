local M = {}
M.setup = function ()
    local lsp_config = require('config._lsp_config');
    local config = lsp_config.make_config()
    M.modify(config)
	require("lspconfig").sourcekit.setup(config)
    -- require("lspconfig").sourcekit.setup(config)
end
M.modify = function(config)
	config.default_config = {
		cmd = {
			"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
			-- "xcrun",
			-- "sourcekit-lsp",
			"-Xswiftc",
			"-sdk",
			"-Xswiftc",
			"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk",
			"-Xswiftc",
			"-target",
			"-Xswiftc",
			"x86_64-apple-ios16.1-simulator",
		},
		root_dir = require("lspconfig/util").root_pattern("Package.swift"),
		filetypes = { "swift" },
	}
end
return M