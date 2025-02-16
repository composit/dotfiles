require("lspconfig").nixd.setup({
	cmd = { "nixd" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import (builtins.getFlake(toString ./.)).inputs.nixpkgs { }",
			},
			formatting = {
				command = { "alejandra" }, -- Alternative: "nixfmt" or "nixpkgs-fmt"
			},
			options = {
				nixos = {
					expr =
					"let flake = builtins.getFlake(toString ./.); in flake.nixosConfigurations.nz.options",
				},
				home_manager = {
					expr =
					'let flake = builtins.getFlake(toString ./.); in flake.homeConfigurations."user@host".options',
				},
				darwin = {
					expr =
					"let flake = builtins.getFlake(toString ./.); in flake.darwinConfigurations.mbp16.options",
				},
			},
		},
	},
})
