defmodule SandshellApi.Renderers.PageHTML do
  use SandshellApi, :html

  embed_templates "page_html/*"
end
