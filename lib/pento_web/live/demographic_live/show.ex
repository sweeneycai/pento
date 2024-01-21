defmodule PentoWeb.DemographicLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  alias PentoWeb.CoreComponents
  alias Pento.Survey.Demographic

  attr :demographic, Demographic, required: true
  def details(assigns) do
    ~H"""
    <div>
      <h2 class="font-medium text-2xl">
        Demographics <%= raw "&#x2713;" %>
      </h2>
      <%!-- <ul>
        <li>Gender: <%= @demographic.gender %></li>
        <li>Year of birth: <%= @demographic.year_of_birth %></li>
      </ul> --%>
      <CoreComponents.table
        rows={[@demographic]}
        id={to_string(@demographic.id)}>
        <:col :let={demographic} label="Gender">
          <%= demographic.gender %>
        </:col>
        <:col :let={demographic} label="Year of birth">
          <%= demographic.year_of_birth %>
        </:col>
      </CoreComponents.table>
    </div>
    """
  end
end