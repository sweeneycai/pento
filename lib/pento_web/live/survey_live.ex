defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias __MODULE__.Component
  alias PentoWeb.DemographicLive
  alias PentoWeb.DemographicLive.Show
  alias Pento.Survey

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign_demographic()
    }
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {
      :noreply,
      socket
      |> put_flash(:info, "Successfully submit the survey!")
      |> assign(:demographic, demographic)
    }
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end
end
