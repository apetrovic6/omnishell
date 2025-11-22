{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.programs.omnishell.bash = {
    enable = mkEnableOption "Enable Bash via OmniShell";

    enableCompletion = mkOption {
      type = types.bool;
      default = true;
    };

    sessionVariables = mkOption {
      type = types.attrsOf types.str;
      default = {};
    };

    shellAliases = mkOption {
      type = types.attrsOf types.str;
      default = {};
    };

    initExtra = mkOption {
      type = types.lines;
      default = "";
    };
  };
}
