defmodule Pento.Catalog.Product.Query do
  import Ecto.Query
  alias Pento.Catalog.Product
  alias Pento.Survey.{Rating, Demographic}
  alias Pento.Accounts.User

  def base, do: Product

  def with_user_ratings(user) do
    ratings_query = Rating.Query.preload_user(user)
    preload(base(), ratings: ^ratings_query)
  end

  def with_avg_ratings(query \\ base()) do
    from p in query,
      join: r in Rating, on: p.id == r.product_id,
      join: u in User, on: r.user_id == u.id,
      join: d in Demographic, on: u.id == d.user_id,
      group_by: p.id,
      select: {p.name, fragment("?::float", avg(r.stars))}
  end

  @doc """
  Apply age group filter to query.
  """
  def filter_by_age_group(query, "all"), do: query

  def filter_by_age_group(query, "18 and under") do
    birth_year = DateTime.utc_now().year - 18

    from [p, r, u, d] in query,
      where: d.year_of_birth >= ^birth_year
  end

  def filter_by_age_group(query, "18 to 25") do
    birth_year_max = DateTime.utc_now().year - 18
    birth_year_min = DateTime.utc_now().year - 25
    from [p, r, u, d] in query,
      where: d.year_of_birth >= ^birth_year_min and d.year_of_birth <= ^birth_year_max
  end

  def filter_by_age_group(query, "25 to 35") do
    birth_year_max = DateTime.utc_now().year - 25
    birth_year_min = DateTime.utc_now().year - 35
    from [p, r, u, d] in query,
      where: d.year_of_birth >= ^birth_year_min and d.year_of_birth <= ^birth_year_max
  end

  def filter_by_age_group(query, "35 and up") do
    birth_year = DateTime.utc_now().year - 35

    from [p, r, u, d] in query,
      where: d.year_of_birth <= ^birth_year
  end

  @doc """
  Apply gender group filter to query.
  """
  def filter_by_gender(query, "all"), do: query

  def filter_by_gender(query, gender) do
    from [p, r, u, d] in query,
      where: d.gender == ^gender
  end

  @doc """
  Handle zero ratings.
  """
  def with_zero_ratings(query \\ base()) do
    from [p] in query,
      select: {p.name, 0}
  end
end