local M = {}
M.modify = function(config)
	config.default_config = {
		cmd = {
			"xcrun",
			"sourcekit-lsp",
			-- "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
			"-Xswiftc",
			"-sdk",
			"-Xswiftc",
			"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk",
			"-Xswiftc",
			"-target",
			"-Xswiftc",
			"x86_64-apple-ios13.6-simulator",
		},
		root_dir = require("lspconfig/util").root_pattern("Package.swift"),
		filetypes = { "swift" },
	}
end
return M
