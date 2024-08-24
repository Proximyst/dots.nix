{ pkgs, config, lib, ... }:

let
  cfg = config.modules.zsh;
in
with lib;
{
  options.modules.zsh = {
    enable = pkgs.my.mkDisableOption "zsh";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fzf
      eza
    ] ++ (
      (if pkgs.stdenv.isLinux
      then with pkgs; [
        xclip
      ]
      else [ ])
    );

    programs.zsh = {
      enable = true;
      history.size = 10000;
      syntaxHighlighting.enable = true;
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
        "gc!" = "git commit --amend";
        "gcf" = "git commit --fixup";
        "gp!" = "git push --force";
        gdh = "git diff HEAD";
        gdm = "git diff \$(git_main_branch)";
        gdom = "git diff origin/\$(git_main_branch)";
        gdum = "git diff upstream/\$(git_main_branch)";
        grbom = "git rebase origin/\$(git_main_branch)";
        grbum = "git rebase upstream/\$(git_main_branch)";
        grboom = "git rebase --onto origin/\$(git_main_branch)";
        grboum = "git rebase --onto upstream/\$(git_main_branch)";
        grhom = "git reset origin/\$(git_main_branch)";
        grhum = "git reset upstream/\$(git_main_branch)";
        grhhom = "git reset --hard origin/\$(git_main_branch)";
        grhhum = "git reset --hard upstream/\$(git_main_branch)";
        gs = "git status";
        grao = "git remote add origin";
        grau = "git remote add upstream";
        grseto = "git remote set-url origin";
        grsetu = "git remote set-url upstream";
        gcpnc = "git cherry-pick --no-commit";
        ls = "eza -F";
        l = "ls -l --git";
        ll = "l -h";
        la = "l -aF";
      } // (if pkgs.stdenv.isLinux
      then {
        copy = "xclip -selection clipboard";
        paste = "xclip -o -selection clipboard";
      }
      else { });

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
          git switch -c "mariellh/$@"
        }

        function gswCm() {
          if [ -z "$@" ]; then
            echo "fatal: no branch name given" >&2
            return 1
          fi
          git switch -C "mariellh/$@"
        }
      '';
    };
  };
}
