defmodule SandshellApi.Handlers.ManifestHandler do
  @moduledoc """
  Handler serves information about the service.
  """

  use SandshellApi, :controller

  @doc """
  Returns information about the service to connection as json.
  """
  def handle(conn, _params) do
    SandshellApi.manifest()
    |> Jason.OrderedObject.new()
    |> then(&json(conn, &1))
  end
end
