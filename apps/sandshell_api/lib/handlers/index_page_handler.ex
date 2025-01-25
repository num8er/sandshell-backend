defmodule SandshellApi.Handlers.IndexPageHandler do
  @moduledoc """
  Handler serving landing page
  """

  use SandshellApi, :controller

  def handle(conn, _params) do
    index_file = Path.join(:code.priv_dir(:sandshell_api), "/static/index.html")

    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, index_file)
  end
end
