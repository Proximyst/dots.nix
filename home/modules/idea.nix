{ config, lib, pkgs, ... }:

let
  cfg = config.modules.idea;
in
with lib;
{
  options.modules.idea = {
    enable = mkEnableOption "idea";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains.idea-community
    ];

    home.file.".ideavimrc".text = ''
      set surround
      set multiple-cursors
      set commentary
      set highlightedyank
      set rnu

      let mapleader = " "
      let maplocalleader = " "
      nnoremap <leader>gd :action GotoDeclaration<CR>
      nnoremap <leader>gD :action GotoDeclaration<CR>
      nnoremap <leader>p :action ParameterInfo<CR>
      nnoremap <leader>f :action ReformatCode<CR>
      nnoremap <leader>t :action RenameElement<CR>
      nnoremap <leader>rn :action RenameElement<CR>
      nnoremap <leader>u :action GotoSuperMethod<CR>
      nnoremap <leader>s "+
      nnoremap <leader>j <C-W>j
      nnoremap <leader>k <C-W>k
      nnoremap <leader>l <C-W>l
      nnoremap <leader>h <C-W>h
      nnoremap <leader>H :noh<CR>
      nnoremap <leader>tl :tabnext<CR>
      nnoremap <leader>th :tabprev<CR>
      nnoremap <leader>tj :tablast<CR>
      nnoremap <leader>tk :tabfirst<CR>
      nnoremap <leader>tq :tabclose<CR>
      nnoremap <leader>tw :tabclose<CR>
      nnoremap <leader>ac :action ShowIntentionActions<CR>
      nnoremap <leader>dj :action GotoNextError<CR>
      nnoremap <leader>dk :action GotoPreviousError<CR>
    '';
  };
}
