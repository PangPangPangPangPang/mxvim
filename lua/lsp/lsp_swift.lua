local M = {}
M.modify = function(config)
	config.cmd = {
		"xcrun",
		-- "sourcekit-lsp",
        "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
		"-Xswiftc",
		"-sdk",
		"-Xswiftc",
		"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk",
		"-Xswiftc",
		"-target",
		"-Xswiftc",
		"x86_64-apple-ios13.6-simulator",
	}
    config.root_dir = require("lspconfig/util").root_pattern("Package.swift")

end
return M
