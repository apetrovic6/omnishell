{
  self,
  config,
  ...
}: {
  flake.homeModules.bash= {
    lib,
    config,
    ...
  }: let
    inherit (lib) mkDefault mkIf;
    cfg = config.programs.omnishell.bash;
  in {
    imports = [
      ../core/bash.nix
    ];

    config = mkIf cfg.enable {
      programs.bash = {
        enable = true;
        enableCompletion = mkDefault cfg.enableCompletion;
        autosuggestion.enable = mkDefault cfg.enableAutosuggest;
        syntaxHighlighting.enable = mkDefault cfg.enableSyntaxHighlight;
        shellAliases = mkDefault cfg.shellAliases;
        initExtra = mkDefault cfg.initExtra; # HM uses initExtra
        initContent = ''
        '';
      };
    };
  };

  flake.nixosModules.bash = {
    lib,
    config,
    ...
  }: let
    cfg = config.programs.omnishell.zsh;
  in {
    imports = [
      ../core/bash.nix
    ];

    config = lib.mkIf cfg.enable {
      programs.bash = {
        enable = true;
        enableCompletion = cfg.enableCompletion;
        sessionVariables = cfg.sessionVariables;
        shellAliases = cfg.shellAliases;
        initExtra= cfg.initExtra; # NixOS uses interactiveShellInit

        environment.pathsToLink = [
          "/share/zsh"
        ];
      };
    };
  };

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
