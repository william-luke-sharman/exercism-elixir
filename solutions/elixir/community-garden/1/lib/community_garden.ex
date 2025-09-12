# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {1, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, plots} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {counter, plots} ->
      new_plot = %Plot{plot_id: counter, registered_to: register_to}
      {new_plot, {counter + 1, [new_plot | plots]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {counter, plots} ->
      filtered_plots = Enum.filter(plots, fn p -> p.plot_id != plot_id end)
      {counter, filtered_plots}
    end)
  end

  def get_registration(pid, plot_id) do
    plots = list_registrations(pid)
    Enum.find(plots, {:not_found, "plot is unregistered"}, fn p -> p.plot_id == plot_id end)
  end
end
