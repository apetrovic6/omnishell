{
  description = "OmniShell — portable shell & CLI config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    home-manager,
    import-tree,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

      imports = [
        inputs.treefmt-nix.flakeModule
        (import-tree ./parts)
      ];

      flake.homeModules.default = {
        imports = [
          self.homeModules.zoxide
self.homeModules.zsh
        ];
      };

      flake.nixosModules.default = {
        imports = [
          #          self.nixosModules.zsh
        ];
      };

      flake.darwinModules.default = {
        imports = [
          #          self.darwinModules.zsh
        ];
      };

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        packages.omni-tools = pkgs.buildEnv {
          name = "omni-tools";
          paths = with pkgs; [zsh zoxide fzf fd ripgrep bat eza starship];
        };

        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true; # Nix formatter
          # add more: programs.prettier.enable = true; etc.
        };

        devShells.default = pkgs.mkShell {
          packages = [self.packages.${system}.omni-tools];
          shellHook = ''echo "OmniShell tools ready."'';
        };
      };
    };
}
