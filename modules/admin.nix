{
    inputs,
    pkgs,
    ...
}:
{
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    system.stateVersion = "25.05"; # no touchy - at all
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];
    users.groups.nixos = { };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
        "electron-39.8.10"
    ];
    environment.systemPackages = with pkgs; [
        nixfmt
        nixd
        nil

        pciutils
        usbutils
    ];
    systemd.tmpfiles.settings."10-nixos-directory"."/etc/nixos".d = {
        user = "root";
        group = "nixos";
        mode = "0775";
    };

    users.users.julia = {
        isNormalUser = true;
        description = "julia";
        extraGroups = [
            "networkmanager"
            "video"
            "plugdev"
            "audio"
            "wheel"
            "nixos"
        ];

        shell = pkgs.zsh;
    };

    security.pam.loginLimits = [
        {
            domain = "@audio";
            type = "-";
            item = "rtprio";
            value = "95";
        }
        {
            domain = "@audio";
            type = "-";
            item = "memlock";
            value = "524288";
        } # optional
    ];
}
