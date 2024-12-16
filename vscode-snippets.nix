{ pkgs }:

let
  snippetsJson = builtins.toJSON {
    "Insert Raw HTML" = {
      prefix = "raw";
      body = [
        "{{< raw >}}"
        "$\{1: markdown_content}"
        "{{< /raw >}}"
      ];
      description = "Insert Raw HTML";
    };
    "Sup" = {
      prefix = "sup";
      body = [
        "<sup>$\{1:}</sup>"
      ];
      description = "Superindex";
    };
    "Sub" = {
      prefix = "sub";
      body = [
        "<sub>$\{1:}</sub>"
      ];
      description = "Subindex";
    };
    "greek" = {
      prefix = "greek";
      body = [
        "α β γ δ ε ζ η θ ι κ λ μ ν ξ ο π ρ σ τ υ φ χ ψ ω"
      ];
      description = "greek";
    };
    "maths" = {
      prefix = "maths";
      body = [
        "≈ ≡ ≋ ≆ ≠ ≉ ∙ ∼ ⋄ ∴ ⊥ ∎ ∈ ∉ ∅ ⊆ ⊇ ≼ ℕ ℤ ℚ ℝ ℂ ∀ ∃ ∂ Δ ∇ ∞ ± ÷ × ∆ √ ∫ ∏ ∑"
      ];
      description = "maths";
    };
    "Text" = {
      prefix = "ltxtext";
      body = [
        "\\text{$\{1:}}"
      ];
      description = "Text";
    };
    "ltxex" = {
      prefix = "ltxex";
      body = [
        "^{$\{1:}}"
      ];
      description = "ltxex";
    };
    "ltxbar" = {
      prefix = "ltxbar";
      body = [
        "\\bar{$\{1:}}"
      ];
      description = "ltxbar";
    };
    "ltxsqrt" = {
      prefix = "ltxsqrt";
      body = [
        "\\sqrt{$\{1:}}"
      ];
      description = "ltxsqrt";
    };
    "ltxsum" = {
      prefix = "ltxsum";
      body = [
        "\sum_{i=0}^\infty i $\{1:}"
      ];
      description = "ltxsum";
    };
    "ltxlim" = {
      prefix = "ltxlim";
      body = [
        "\\lim_{\\Delta x \\to 0} $\{1:}"
      ];
      description = "ltxlim";
    };
    "Frac" = {
      prefix = "ltxfr";
      body = [
        "\\frac{$\{1:}}{$\{2:}}"
      ];
      description = "Fraction";
    };
    "ltxint" = {
      prefix = "ltxint";
      body = [
        "\\int f(x)dx"
      ];
      description = "ltxint";
    };
    "ltxindef" = {
      prefix = "ltxindef";
      body = [
        "\\int_{a}^{b} f(x)dx"
      ];
      description = "ltxindef";
    };
    "highlight" = {
      prefix = "highlight";
      body = [
        "{{< highlight \"$\{1:}\" >}}"
      ];
      description = "highlight";
    };
     "ltxmatr" = {
      prefix = "ltxmatr";
      body = [
        "$(\\begin{smallmatrix}a & 0\\\\\\\ 0 & b\\end{smallmatrix})$"
      ];
      description = "ltxmatr";
    };
    "Insert Bordes" = {
      prefix = "bordes";
      body = [
        "{{% pborder %}}"
        "$\{1: markdown_content}"
        "{{% /pborder %}}"
      ];
      description = "Insert Bordes";
    };
    "Insert Code" = {
      prefix = "code";
      body = [
        "``` $\{1|html,python,md,bash,javascript,json|} "
        "$\{2: markdown_content}"
        "```"
      ];
      description = "Insert Code";
    };
    "Markdown link" = {
      prefix = "link";
      body = [
        "[$\{1: link_text}]($\{2: link_url})"
      ];
      description = "Markdown link";
    };
    "Alert" = {
      prefix = "alert";
      body = [
        "{{< alert $\{1|primary,secondary,success,danger,warning,info,light,alert|}>}}"
        "<i class='fas fa-exclamation-triangle'></i>$\{2: markdown_content}"
        "{{< /alert >}}"
      ];
      description = "Alerts Bootstraps";
    };
  };
  markdownSnippets = pkgs.writeText "markdown.json" snippetsJson;
in
{
  markdownSnippets = markdownSnippets;
}
