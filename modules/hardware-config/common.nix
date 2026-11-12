{ ... }:
{
    boot = {
        plymouth = {
            enable = true;
            logo = ../../res/lix-snowflake.png;
        };
    };
    services.upower.enable = true;

}
