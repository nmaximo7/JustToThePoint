{ config, pkgs, ... }:
let
  home = config.home;
  snippets = import /home/nmaximo7/dotfiles/vscode-snippets.nix { inherit pkgs; };
in
{
  programs.vscode = {
  	enable = true;
  	package = pkgs.vscode;
  	extensions = with pkgs.vscode-extensions; [
    		dracula-theme.theme-dracula
    		yzhang.markdown-all-in-one
    		oderwat.indent-rainbow
    		pkief.material-icon-theme
    		ms-python.python
    		esbenp.prettier-vscode
    		streetsidesoftware.code-spell-checker
  	]; # extensions
  	userSettings = {
  		"editor.snippetSuggestions" = "top";
	    	"[markdown]" = {
	    		"editor.quickSuggestions" = {
				"other" = true;
				"comments" = false;
				"strings" = false;
			};
	      	};
	        "window.zoomLevel" = 0.5; # Adjust this value as needed
  		"files.autoSave" = "afterDelay";
    		"files.autoSaveDelay" = 1000;
    		"editor.formatOnSave" = true;
    		"editor.renderWhitespace" = "all";
    		"files.trimTrailingWhitespace" = true;
    		"workbench.colorTheme" = "Dracula";
    		"workbench.iconTheme" = "material-icon-theme";
    		"workbench.startupEditor" = "none";
    		"python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
    		"cSpell.language" = "en,es"; # Define languages for spell checking
    		"cSpell.enableFiletypes" = ["markdown" "plaintext" "javascript" "python"]; # Specify file types to enable spell checking
		"cSpell.ignoreWords" = ["nmaximo7"]; # Add any custom words to ignore
  	}; # userSettings
  	keybindings = [
	 {
	      key = "tab";
	      command = "snippetInsert";
	      when = "editorTextFocus && hasSnippetCompletions && !editorTabMovesFocus && !inSnippetMode";
	  }
	 ]; # keybindings
    }; # vscode
    home.file.".config/Code/User/snippets/markdown.json".source = snippets.markdownSnippets;
}

