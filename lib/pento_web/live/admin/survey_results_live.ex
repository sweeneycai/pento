defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component

  alias Pento.Catalog
  alias PentoWeb.BarChart

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     #  |> assign(%{products_with_avg_ratings: Catalog.products_with_avg_ratings()})
     |> assign(:gender_filter, "all")
     |> assign(:age_group_filter, "all")
     |> assign(
       :chart_svg,
       BarChart.render_product_rating_bar_chart(Catalog.products_with_avg_ratings())
     )}
  end

  def handle_event(
        "age_group_filter",
        %{"age_group_filter" => age_group_filter},
        socket
      ) do
    case Catalog.products_with_avg_ratings(%{age_group_filter: age_group_filter}) do
      [] ->
        {:noreply,
         assign(
           socket,
           :chart_svg,
           BarChart.render_product_rating_bar_chart(Catalog.products_with_zero_ratings())
         )}

      products ->
        {
          :noreply,
          assign(
            socket,
            :chart_svg,
            BarChart.render_product_rating_bar_chart(products)
          )
        }
    end
  end

  def handle_event(
        "gender_filter",
        %{"gender_filter" => gender_filter},
        socket
      ) do
    case Catalog.products_with_avg_ratings(%{gender_filter: gender_filter}) do
      [] ->
        {:noreply,
         assign(
           socket,
           :chart_svg,
           BarChart.render_product_rating_bar_chart(Catalog.products_with_zero_ratings())
         )}

      products ->
        {:noreply,
         assign(
           socket,
           :chart_svg,
           BarChart.render_product_rating_bar_chart(products)
         )}
    end
  end
end
