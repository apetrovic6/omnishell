{...}: {
  flake.homeModules.zoxide = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkDefault mkIf;
    cfg = config.programs.omnishell.zoxide;
  in {
    imports = [
      ../core/zoxide.nix
    ];
    config = mkIf cfg.enable {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = mkDefault cfg.enableZshIntegration;
        enableBashIntegration = mkDefault cfg.enableBashIntegration;
        enableFishIntegration = mkDefault cfg.enableFishIntegration;
        options = ["--cmd" cfg.command] ++ cfg.extraCommands;
      };
    };
  };
}
