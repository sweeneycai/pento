defmodule Pento.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false

  alias Pento.Repo
  alias Pento.Catalog.Product


  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  @doc """
  Decrease unit price of a product, raise error
  while unit price is bigger than before or less than 0.0.

  ## Examples
  
      iex> markdown_product(product, down_amount)
      {:ok, %Product{}}
      iex> markdown_product(product, down_amount)
      {:error, %Ecto.changeset{}}
  """
  def markdown_product(%Product{} = product, down_amount) do
    product
    |> Product.markdown_changeset(%{unit_price: product.unit_price - down_amount})
    |> Repo.update()
  end

  def products_with_zero_ratings() do
    Product.Query.with_zero_ratings()
    |> Repo.all()
  end

  def list_products_with_user_rating(user) do
    Product.Query.with_user_ratings(user) |> Repo.all()    
  end

  def products_with_avg_ratings() do
    Product.Query.with_avg_ratings()
    |> Repo.all()
  end

  def products_with_avg_ratings(%{age_group_filter: age_group_filter}) do
    Product.Query.with_avg_ratings()
    |> Product.Query.filter_by_age_group(age_group_filter)
    |> Repo.all()
  end

  def products_with_avg_ratings(%{gender_filter: gender_filter}) do
    Product.Query.with_avg_ratings()
    |> Product.Query.filter_by_gender(gender_filter)
    |> Repo.all()
  end
end
