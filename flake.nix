{
  description = "OmniShell — portable shell & CLI config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    import-tree.url = "github:vic/import-tree";
    helix = {
      #      url = "github:apetrovic6/magos";
      url = "path:/home/apetrovic/clan/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    helix,
    home-manager,
    import-tree,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.treefmt-nix.flakeModule
        (import-tree ./modules)
        ./lib/utils/merge-hm-modules.nix
      ];

      flake.homeManagerModules.default = {
        pkgs,
        lib,
        config,
        ...
      }: let
        inherit (lib) mkDefault;
      in {
        imports = [
          self.homeModules.zsh
          self.homeModules.zoxide
          self.homeModules.bash
          self.homeModules.starship
          self.homeModules.fastfetch
        ];

        programs.omnishell.starship.enable = mkDefault true;

        programs.lazygit = {
          enable = true;
          enableBashIntegration = mkDefault config.programs.omnishell.bash.enable;
          enableZshIntegration = mkDefault config.programs.omnishell.zsh.enable;
        };

        programs.helix = {
          enable = true;
          package = helix.packages.${pkgs.system}.default;
        };

        programs.eza = {
          enable = true;
          git = true;
        };

        programs.bat.enable = true;

        programs.omnishell.zsh.enable = true;
        programs.omnishell.zoxide.enable = true;
        programs.omnishell.bash = {
          enable = true;
          initExtra = ''
            fastfetch
          '';
        };
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
