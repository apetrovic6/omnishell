# modules/home/omnishell/zsh/index.nix  (flake-parts module that exports flake.*)
{self, ...}: {
  # ❌ REMOVE any top-level flake-parts `imports = [ ./core.nix ];`
  # We import `core.nix` INSIDE each adapter module below.

  flake.homeModules.zsh = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.omnishell.zsh;
  in {
    config = lib.mkIf cfg.enable {
      programs.zsh = {
        enable = true;
        enableCompletion = cfg.enableCompletion;
        autosuggestions.enable = cfg.enableAutosuggest;
        syntaxHighlighting.enable = cfg.enableSyntaxHighlight;
        shellAliases = cfg.shellAliases;
        initExtra = cfg.initExtra; # HM uses initExtra
      };
    };
  };

  # flake.nixosModules.zsh = { lib, config, ... }:
  # let cfg = config.programs.omnishell.zsh;
  # in {
  #   imports = [ ./core.nix ];  # ← normal NixOS import
  #   config = lib.mkIf cfg.enable {
  #     programs.zsh = {
  #       enable = true;
  #       enableCompletion              = cfg.enableCompletion;
  #       autosuggestions.enable        = cfg.enableAutosuggest;
  #       syntaxHighlighting.enable     = cfg.enableSyntaxHighlight;
  #       shellAliases                  = cfg.shellAliases;
  #       interactiveShellInit          = cfg.initExtra;   # NixOS uses interactiveShellInit
  #     };
  #   };
  # };

  # flake.darwinModules.zsh = { lib, config, ... }:
  # let cfg = config.programs.omnishell.zsh;
  # in {
  #   imports = [ ./core.nix ];  # ← normal Darwin import
  #   config = lib.mkIf cfg.enable {
  #     programs.zsh = {
  #       enable = true;
  #       enableCompletion              = cfg.enableCompletion;
  #       autosuggestions.enable        = cfg.enableAutosuggest;
  #       syntaxHighlighting.enable     = cfg.enableSyntaxHighlight;
  #       shellAliases                  = cfg.shellAliases;
  #       interactiveShellInit          = cfg.initExtra;   # nix-darwin also uses interactiveShellInit
  #     };
  #   };
  # };
}
