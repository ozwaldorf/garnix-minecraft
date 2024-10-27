{
  description = "garnix minecraft server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-24.05";
    garnix-lib.url = "github:garnix-io/garnix-lib";
  };

  outputs = inputs: {
    nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
      modules = [ inputs.garnix-lib.nixosModules.garnix ./host.nix ];
    };
  };
}
