defmodule HelloWorldWeb.CounterLive do
  use HelloWorldWeb, :live_view

  @topic "counter"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      HelloWorldWeb.Endpoint.subscribe(@topic)
    end

    {:ok, assign(socket, count: Counter.get())}
  end

  def handle_event("increment", _, socket) do
    new_count = Counter.increment()
    HelloWorldWeb.Endpoint.broadcast(@topic, "update", %{count: new_count})
    {:noreply, assign(socket, count: new_count)}
  end

  def handle_event("decrement", _, socket) do
    new_count = Counter.decrement()
    HelloWorldWeb.Endpoint.broadcast(@topic, "update", %{count: new_count})
    {:noreply, assign(socket, count: new_count)}
  end

  def handle_info(%{event: "update", payload: %{count: count}}, socket) do
    {:noreply, assign(socket, count: count)}
  end

  def render(assigns) do
    ~H"""
    <div class="text-center mt-10">
      <h1 class="text-4xl mb-6">Count: <%= @count %></h1>
      <button phx-click="decrement" class="bg-red-500 text-white px-6 py-2 rounded text-2xl">-</button>
      <button phx-click="increment" class="bg-green-500 text-white px-6 py-2 rounded text-2xl ml-4">+</button>
    </div>
    """
  end
end
