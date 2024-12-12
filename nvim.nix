{ config, pkgs, ... }:

{
  # Enable Neovim
  programs.neovim = {
    enable = true;  # Ensure Neovim is installed and enabled

    # Specify the Neovim package version
    withPython3 = true;
    extraPython3Packages = ps: with ps; [ pynvim ];
    
    # Configuration for Neovim
    extraConfig = ''
      " Set leader key
      let mapleader = " "  " Use space as the leader key

      " General settings
      set number          " Show line numbers
      set relativenumber  " Show relative line numbers
      set tabstop=4       " Number of spaces per tab
      set shiftwidth=4     " Number of spaces for autoindent
      set expandtab       " Convert tabs to spaces
      set nowrap          " Disable line wrapping

      " Enable syntax highlighting
      syntax on

      " Plugins settings (using vim-plug as an example)
      call plug#begin('~/.local/share/nvim/plugged')
      Plug 'preservim/nerdtree'  " File explorer
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
      Plug 'morhetz/gruvbox'  " Color scheme
      call plug#end()

      " Set colorscheme
      colorscheme gruvbox  " Set the colorscheme to gruvbox

      " Key mappings
      nnoremap <leader>n :NERDTreeToggle<CR>  " Toggle NERDTree
      nnoremap <leader>f :FZF<CR>  " Open FZF
    '';

    # Specify additional plugins if needed
    plugins = with pkgs.vimPlugins; [
      # Add any additional plugins here
      vim-sensible  # A sensible default configuration
    ];
  };
}
