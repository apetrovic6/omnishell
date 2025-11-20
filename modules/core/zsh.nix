{ lib, ... }:
let inherit (lib) mkEnableOption mkOption types;
in {
  options.programs.omnishell.zsh = {
    enable = mkEnableOption "Enable Zsh via OmniShell";

    enableCompletion     = mkOption { type = types.bool; default = true;  };
    enableAutosuggest    = mkOption { type = types.bool; default = true;  };
    enableSyntaxHighlight= mkOption { type = types.bool; default = true;  };
    shellAliases         = mkOption { type = types.attrsOf types.str; default = {}; };
    initExtra            = mkOption { type = types.lines; default = ""; };
  };
}
