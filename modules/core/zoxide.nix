{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption mkEnableOption types;
  zshOn = config.programs.omnishell.zsh.enable  or false;
  bashOn = config.programs.omnishell.bash.enable or false;
  fishOn = config.programs.omnishell.fish.enable or false;
in {
  options.programs.omnishell.zoxide = {
    enable = mkEnableOption "Enable Omnishell zoxide";

    enableZshIntegration = mkOption {
      type = types.bool;
      default = zshOn;
      description = "Enable Zsh integration (defaults to true if Omnishell Zsh is enabled).";
    };
    enableBashIntegration = mkOption {
      type = types.bool;
      default = bashOn;
      description = "Enable Bash integration (defaults to true if Omnishell Bash is enabled).";
    };
    enableFishIntegration = mkOption {
      type = types.bool;
      default = fishOn;
      description = "Enable Fish integration (defaults to true if Omnishell Fish is enabled).";
    };

    command = mkOption {
      type = types.str;
      default = "z";
      description = "Command name used to invoke zoxide.";
    };

    extraCommands = mkOption {
      type = types.listOf types.str;
      default = [];
      example = ["--hook" "pwd" "--no-cmd"];
      description = "Extra flags for zoxide init.";
    };
  };
}
