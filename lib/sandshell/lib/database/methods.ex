defmodule Sandshell.Database.Methods do
  @moduledoc """
  Module to provide CouchDB methods.
  """

  alias :poolboy, as: Poolboy

  def server_info do
    call_on_worker(:server_info)
  end

  def call_on_worker(method) do
    Poolboy.transaction(:couchdb_pool, fn worker_pid ->
      GenServer.call(worker_pid, method)
    end)
  end
end
