{
  self,
  config,
  ...
}: {
  flake.homeModules.fastfetch = {
    lib,
    config,
    ...
  }: let
    inherit (lib) mkDefault mkIf;
    cfg = config.programs.omnishell.fastfetch;
  in {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = ''
                ___   __
         /¯\    \  \ /  ;
         \  \    \  v  /
      /¯¯¯   ¯¯¯¯\\   /  /\
     ’————————————·\  \ /  ;
          /¯¯;      \ //  /_
    _____/  /        ‘/     \
    \      /,        /  /¯¯¯¯
     ¯¯/  // \      /__/
      .  / \  \·————————————.
       \/  /   \\_____   ___/
          /  ,  \     \  \
          \_/ \__\     \_/
          ''; # nixos / nixos_small / auto / file path...
          type = "data-raw";
          # width = 5;
          # height = 5;
          padding = {
            top = 2;
            left = 2;
            right = 2;
          };
        };

 display = {
    size = {
       binaryPrefix = "si";
    };
    color = "blue";
    separator = " ";
  };


          modules = [
          {type = "break";}
          {
            type = "os";
            key = " ";
          }
          {
            type = "kernel";
            key = " ";
          }
          {
            type = "uptime";
            key = "󰅐 ";
          }
          {
            type = "packages";
            key = "󰏖 ";
          }

          # {type = "break";}

          {
            type = "shell";
            key = " ";
          }
          {
            type = "wm";
            key = " ";
          }
          {
            type = "de";
            key = " ";
          }
          {
            type = "terminal";
            key = " ";
          }

          # {type = "break";}

          {
            type = "cpu";
            key = " ";
            showTemperature = true;
          }
          {
            type = "gpu";
            key = "󰢮 ";
          }
          {
            type = "memory";
            key = " ";
          }
          {
            type = "disk";
            key = " ";
            folders = ["/"];
          }
          {
            type = "display";
            key = "󰍹 ";
          }
          {
            type = "localip";
            key = " ";
          }

          {type = "break";}

          {
            type =  "custom";
            format = "{#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}  {#38}  {#39} ";
          }
        ];
      };
    };
  };

  # flake.nixosModules.zsh = {
  #   lib,
  #   config,
  #   ...
  # }: let
  #   cfg = config.programs.omnishell.zsh;
  # in {
  #   imports = [
  #     ../core/zsh.nix
  #   ];

  #   config = lib.mkIf cfg.enable {
  #     programs.zsh = {
  #       enable = true;
  #       enableCompletion = cfg.enableCompletion;
  #       autosuggestion.enable = cfg.enableAutosuggest;
  #       syntaxHighlighting.enable = cfg.enableSyntaxHighlight;
  #       shellAliases = cfg.shellAliases;
  #       interactiveShellInit = cfg.initExtra; # NixOS uses interactiveShellInit
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
