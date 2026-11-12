{
    pkgs,
    ...
}:
{
    programs = {
        steam = {
            enable = true;
            gamescopeSession.enable = true;
            remotePlay.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
            protontricks.enable = true;
            extraCompatPackages = with pkgs; [
                proton-ge-bin
            ];
        };
        gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
        openrct2
        olympus
        prismlauncher # mincecraft
        azahar # ds emulator
    ];
}
