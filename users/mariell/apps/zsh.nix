{ pkgs
, platform
, ...
}:

let
  platformPkgs = {
    linux = with pkgs; [
    xclip
    ];
    darwin = with pkgs; [
    ];
  };

  platformAliases = {
    linux = {
      copy = "xclip -selection clipboard";
      paste = "xclip -o -selection clipboard";
    };
    darwin = {
      copy = "pbcopy";
      paste = "pbpaste";
      kssh = "kitty +kitten ssh";
      k = "kubectl";
      dehyphen = "tr -d '-'";
    };
  };

  # TODO: Replace this with Nix management
  platformConfig = {
    linux = "";
    darwin = ''
export PATH=/run/current-system/etc/profiles/per-user/mariellh/bin:"$PATH"

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
. $HOME/.asdf/plugins/java/set-java-home.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    '';
  };
in
{
  home.packages = (with pkgs; [
    fzf
    eza
  ]) ++ platformPkgs."${platform}";

  programs.zsh = {
    enable = true;
    history.size = 10000;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.catppuccin.enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "robbyrussell";
    oh-my-zsh.plugins = [ "git" "1password" "fzf" ];
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
      v = "nvim";
      q = "exit";
      ":q" = "exit";
      ":wq" = "exit";
      ":x" = "exit";
      gg = "glods";
      "gc!" = "gc --amend";
      "gcf" = "gc --fixup";
      "gp!" = "gp --force";
      gdh = "gd HEAD";
      gdm = "gd \\$(git_main_branch)";
      gdom = "gd origin/\\$(git_main_branch)";
      gdum = "gd upstream/\\$(git_main_branch)";
      grbom = "grb origin/\\$(git_main_branch)";
      grbum = "grb upstream/\\$(git_main_branch)";
      grboom = "grbo origin/\\$(git_main_branch)";
      grboum = "grbo upstream/\\$(git_main_branch)";
      grhom = "grh origin/\\$(git_main_branch)";
      grhum = "grh upstream/\\$(git_main_branch)";
      grhhom = "grhh origin/\\$(git_main_branch)";
      grhhum = "grhh upstream/\\$(git_main_branch)";
      gs = "gst";
      grao = "gra origin";
      grau = "gra upstream";
      grseto = "grset origin";
      grsetu = "grset upstream";
      gcpnc = "gcp --no-commit";
      ls = "eza -F";
      l = "ls -l --git";
      ll = "l -h";
      la = "l -aF";
      j = "jump";
    } // platformAliases."${platform}";

    oh-my-zsh.extraConfig = ''
      function mde() {
        if [ -z "$@" ]; then
          echo "fatal: no dir supplied" >&2
          return 1
        fi

        if [ -d "$@" ]; then
          echo "warning: directory already exists" >&2
        else
          mkdir -p "$@"
        fi

        cd "$@"
      }

      function gswcm() {
        if [ -z "$@" ]; then
          echo "fatal: no branch name given" >&2
          return 1
        fi
        gswc "mariellh/$@"
      }

      function gswCm() {
        if [ -z "$@" ]; then
          echo "fatal: no branch name given" >&2
          return 1
        fi
        gsw -C "mariellh/$@"
      }

      ${platformConfig."${platform}"}
    '';
  };
}
