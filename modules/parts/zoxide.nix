{...}:
{
  flake.homeModules.zoxide = { config, lib, pkgs, ...}:
let
    inherit (lib) mkIf mkOption mkEnableOption types;
   cfg = config.programs.omnishell.zsh;

in
   {
 config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration  = mkDefault cfg.enableZshIntegration;
      enableBashIntegration = mkDefault cfg.enableBashIntegration;
      enableFishIntegration = mkDefault cfg.enableFishIntegration;
      options = [ "--cmd" cfg.command ] ++ cfg.extraCommands;
    };
  };

  };

}
