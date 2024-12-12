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
