defmodule PentoWeb.Presence do
  use Phoenix.Presence,
    otp_app: :pento,
    pubsub_server: Pento.PubSub

  alias PentoWeb.Presence

  @user_activity_topic "user_activity"

  def track_user(pid, product, user_email) do
    Presence.track(
      pid,
      @user_activity_topic,
      product.name,
      %{users: [%{email: user_email}]}
    )
  end

  @doc """
  Get active users and coresponding products. Sample data like this:

  ```elixir
  %{
    "Kingdom Rush Origins" => %{
      metas: [
        %{phx_ref: "F7nnnxjJRmNPGiAD", users: [%{email: "user-2@example.com"}]}
      ]
    },
    "Kingdom Rush Vengeance" => %{
      metas: [
        %{phx_ref: "F7nnh-dxxidPGh7D", users: [%{email: "user-1@example.com"}]}
      ]
    }
  }
  ```
  """
  def list_products_and_users do
    Presence.list(@user_activity_topic)
    |> Enum.map(&extract_product_with_users/1)
  end

  def extract_product_with_users({product_name, %{metas: metas}}) do
    {
      product_name,
      Enum.flat_map(metas, fn meta_map -> get_in(meta_map, [:users]) end)
      |> Enum.uniq()
    }
  end
end
