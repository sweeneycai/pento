defmodule PentoWeb.Admin.UserActivityLive do
  use PentoWeb, :live_component
  alias PentoWeb.Presence

  def update(_assigns, socket) do
    {:ok,
     socket
     |> assign(
       :user_activity,
       Presence.list_products_and_users()
     )
    |> assign(:data, Presence.list("user_activity"))}
  end

  
end
