defmodule Pento.Survey.Demographic.Query do
  import Ecto.Query
  alias Pento.Survey.Demographic

  def _base do
    Demographic
  end

  def for_user(query \\ _base(), user) do
    query
    |> where([d], d.user_id == ^user.id)
  end
end