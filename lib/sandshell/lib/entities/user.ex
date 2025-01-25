defmodule User do
  @moduledoc """
  User entity
  """

  defstruct [
    :id,
    :credentials,
    :personal,
    :_rev
  ]
end
