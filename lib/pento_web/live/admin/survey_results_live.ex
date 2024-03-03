defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component

  alias Pento.Catalog
  alias PentoWeb.BarChart

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     #  |> assign(%{products_with_avg_ratings: Catalog.products_with_avg_ratings()})
     |> assign_gender_filter()
     |> assign_age_group_filter()
     |> assign(
       :chart_svg,
       BarChart.render_product_rating_bar_chart(Catalog.products_with_avg_ratings())
     )}
  end

  def handle_event(
        "filter",
        %{"age_group_filter" => age_group_filter},
        %{assigns: %{gender_filter: gender_filter}} = socket
      ) do
    case Catalog.products_with_avg_ratings(%{
           age_group_filter: age_group_filter,
           gender_filter: gender_filter
         }) do
      [] ->
        {:noreply,
         socket
         |> assign_age_group_filter(age_group_filter)
         |> assign(
           :chart_svg,
           BarChart.render_product_rating_bar_chart(Catalog.products_with_zero_ratings())
         )}

      products ->
        {:noreply,
         socket
         |> assign_age_group_filter(age_group_filter)
         |> assign(
           :chart_svg,
           BarChart.render_product_rating_bar_chart(products)
         )}
    end
  end

  def handle_event(
        "filter",
        %{"gender_filter" => gender_filter},
        %{assigns: %{age_group_filter: age_group_filter}} = socket
      ) do
    case Catalog.products_with_avg_ratings(%{
           age_group_filter: age_group_filter,
           gender_filter: gender_filter
         }) do
      [] ->
        {:noreply,
         socket
         |> assign_gender_filter(gender_filter)
         |> assign(
           :chart_svg,
           BarChart.render_product_rating_bar_chart(Catalog.products_with_zero_ratings())
         )}

      products ->
        {:noreply,
         socket
         |> assign_gender_filter(gender_filter)
         |> assign(
           :chart_svg,
           BarChart.render_product_rating_bar_chart(products)
         )}
    end
  end

  defp assign_gender_filter(%{assigns: %{gender_filter: gender_filter}} = socket) do
    assign(socket, :gender_filter, gender_filter)
  end

  defp assign_gender_filter(socket) do
    assign(socket, :gender_filter, "all")
  end

  defp assign_gender_filter(socket, gender_filter) do
    assign(socket, :gender_filter, gender_filter)
  end

  defp assign_age_group_filter(%{assigns: %{age_group_filter: age_group_filter}} = socket) do
    assign(socket, :age_group_filter, age_group_filter)
  end

  defp assign_age_group_filter(socket) do
    assign(socket, :age_group_filter, "all")
  end

  defp assign_age_group_filter(socket, age_group_filter) do
    assign(socket, :age_group_filter, age_group_filter)
  end
end
