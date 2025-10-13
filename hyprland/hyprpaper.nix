{ ... }:
let
    wallpaper = "~/Pictures/Backgrounds/celeste.png";
in
{
    services.hyprpaper = {
        enable = true;
        settings = {
            splash = false;
            splash_offset = 2.0;

            preload =
                [ wallpaper ];

            wallpaper = [
                ",${wallpaper}"
            ];
        };
    };
}