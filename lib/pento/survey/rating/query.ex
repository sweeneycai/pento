defmodule Pento.Survey.Rating.Query do
  import Ecto.Query

  alias Pento.Survey.Rating

  def base, do: Rating

  def preload_user(user) do
    from r in base(),
      where: r.user_id == ^user.id
  end
end