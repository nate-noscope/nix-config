{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };

    opencode.url = "github:anomalyco/opencode";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    opencode,
    ...
  }: {
    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = [
            nixvim.homeModules.nixvim
          ];

          home-manager.users.nixuser = {
            imports = [
              ./home.nix
            ];

            _module.args.opencode = opencode;
          };
        }
      ];
    };
  };
}
