{ config, pkgs, ... }:

let
  username = config.home.username;
  dotDir = "/home/${username}/dotfiles";
  aliases = import ./aliases.nix;
in

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];

    sessionVariables = {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "underline";
    };

    shellAliases = aliases;


    initExtra = ''
      myripgrep() {
      	rg "$@" ~/justtothepoint/content/
        rg "$@" ~/dotfiles/
      	rg "$@" ~/myNewPython/
      }
      cat() {
      	distrobox enter arch -- cat "$@"
      }
      reloj() {
      	while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &
      }
      header() {
    	echo -e "---\nkeywords: Maths, Learn Math, math, mathematics, school, homework, education, Natural numbers, numbers, Integers, Fractions, Complex numbers\nfeatured_image: /maths/images/DifferentialEquationsFishing.jpg\ndescription: Predator-Prey Model.\nauthor: Máximo Núñez Alarcón\nlanguage: en\nweight: 401\nmath: true\ntitle:\nfirstarticle: Complex Analysis\ndate: $(date +"%Y-%m-%d")\ncategories:\n  - \"maths\" \n  - \"Calculus\" \n  - \"Complex Analysis\" \n---"
      }
      special() {
      	 echo -e "Operators and Relations: ≈ ≡ ≋ ≆ ≠ ≉  ∼ ⋄ ∴ ⊥ ∎\nSet Theory: ∈ ∉ ∅ ⊆ ⊇ ≼ \nNumber Sets: ℕ ℤ ℚ ℝ ℂ\nQuantifiers: ∀ ∃ \nDifferential Operators: ∂ Δ ∇ \nPunctuation and Brackets: {  } ( ) " " ' ' „ ‟ « » — 〈 〉 〔 〕 ﹙ ﹚ ﹛ ﹜\nOther:  @  \  |\nGreek Alphabets: α β γ δ ε ζ η θ ι κ λ μ ν ξ ο π ρ σ τ υ φ χ ψ ω\nOperators: + - ± / × \narrows: ← → ↑ ↓ ↔ ↕ ↖ ↗ ↘ ↙ ⇐ ⇒ ⇑ ⇓ ⇔ ⇕ ⟵ ⟶ ⟷ ⟹ ⬅ ➞ ➟  ➠ ➡ ➢\nspecial characters: ✡ ★ ✪ ✫ ✬ ✭ ✮ ✯ ✰ ✱ ✲ ✳ ✴ ✵ ✶ ✷ ✸ ✹ ✺ ✻ ✼ ✽ ✾ ✿\nsuperindices: ᵃ ᵇ ᶜ ᵈ ᵉ ᵊ ᵋ ᵛ ᵥ ᵦ ᵧ ᵨ ᵩ ᵪ ᵫ ᵬ ᵭ ᵮ ᵯ ᵰ ᵱ ᵲ ᵳ ᵴ ᵵ ᵶ\nSub-indexes: ₐ ₑ ₒ ₓ ₔ ₕ ₖ ₗ ₘ ₙ ₚ ₛ ₜ\nFractions: ½ ⅓ ¼ ⅕ ⅙ ⅐ ⅔ ¾ ⅖ ⅗ ⅘ ⅚ ⅛ ⅜ ⅝ ⅞\nMathematical Symbols: ∞ ± ÷ ∙ × ∆ √ ∫ ∏ ∑ ∂ ∃ ∄ ∈ ∉ ∊ ∋ ∌ ∍\nCurrency Symbols: € $ ¢ £ ¥ ₤ ₳ ₱ ₲ ₴ ₵ ₶ ₷ ₸ ₹\nGeometric Shapes: ● ○ ◐ ◑ ◒ ◓ ◔ ◕ ◖ ◗ ◘ ◙ ◚ ◛ ◜ ◝ ◞ ◟\nMiscellaneous Symbols: ☀ ☁ ☂ ☃ ♠ ♣ ♥ ♦ ♪ ♫ ☎ ✆ ✈ ☢ ☣ ♿ ☮ ✌ ☯ ☸ ⚘"
      }	 
      eval "$(zoxide init zsh --cmd cd)"
      # fastfetch
      cowsay "type inicio | help"
      # distrobox enter arch -- fortune | cowsay
    '';


  };

  programs.starship = {
    enable = true;
    settings = {
      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "🌐 ";
        format = "on [$hostname](bold red) ";
        trim_at = ".local";
        disabled = false;
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

