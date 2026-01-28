defmodule Counter do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def increment do
    Agent.get_and_update(__MODULE__, fn count -> {count + 1, count + 1} end)
  end

  def decrement do
    Agent.get_and_update(__MODULE__, fn count -> {count - 1, count - 1} end)
  end
end
