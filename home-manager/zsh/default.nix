{ pkgs, lib, config, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
                "fzf"
            ];
            theme = "philips";
        };
        initContent = ''
            alias clock='tty-clock -C 2 -r -c'
            alias puppy='echo arf arf!'
            alias ls='ls --color=auto'
            alias grep='grep --color=auto'
            alias p7zip='7z'
            alias cat='bat'
            alias fetch='fastfetch'
            alias please='sudo $(fc -ln -1)'
            alias copy='wl-copy'
            alias paste='wl-paste'
            alias rm="rm -i"

            ~/.local/bin/pokemon-encounter.py chikorita

        '';
    };

    home.file.pokemon-encounter = {
        source = ./pokemon-encounter.py;
        target = ".local/bin/pokemon-encounter.py";
        executable = true;
    };
}