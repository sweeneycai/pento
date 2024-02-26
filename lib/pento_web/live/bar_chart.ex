defmodule PentoWeb.BarChart do
  alias Contex.{Dataset, BarChart, Plot}

  def render_product_rating_bar_chart(data) do
    render_bar_chart(
      data,
      "Product Ratings",
      "avg star ratings per product",
      500,
      400
    )
  end

  defp render_bar_chart(data, title, subtitle, x_axis, y_axis) do
    bar_chart = Dataset.new(data) |> BarChart.new()

    Plot.new(500, 400, bar_chart)
    |> Plot.titles(title, subtitle)
    |> Plot.axis_labels(x_axis, y_axis)
    |> Plot.to_svg()
  end
end
