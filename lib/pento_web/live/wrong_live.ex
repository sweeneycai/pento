defmodule PentoWeb.Live.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.Layouts, :app}

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time(), guess_number: next_guess())}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %> </h1>
    <h2>
      <%= @message %>
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <button class="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded">
            <%= n %>
          </button>
        </.link>
      <% end %>
    </h2>
    <h2>The truth is <%= @guess_number %> </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    if guess == socket.assigns.guess_number do
      score = socket.assigns.score + 1
      message = "Congratulations! You are right, score + 1 : #{score}."
      {:noreply, assign(socket, message: message, score: score, guess_number: next_guess())}
    else 
      message = "Your guess: #{guess}. Wrong, guess agine."
      score = socket.assigns.score - 1
      {:noreply, assign(socket, message: message, score: score)}
    end
  end

  def handle_info(:tick, socket) do
    {:noreply, assign(socket, time: time())}
  end

  def time(), do: DateTime.utc_now |> to_string()
  def next_guess(), do: :rand.uniform(10) |> to_string()
end