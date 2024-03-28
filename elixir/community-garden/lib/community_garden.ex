# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {0, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_count, registrations} -> registrations end)
  end

  def register(pid, register_to) do
    next_id = Agent.get_and_update(pid, fn { count, regs } -> {count, { count + 1, regs }} end)
    plot = %Plot { plot_id: next_id + 1, registered_to: register_to }
    Agent.update(pid, fn { count, regs } -> { count, [plot | regs]} end)
    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {count, regs} -> {count, Enum.reject(regs, & &1.plot_id == plot_id)} end)
  end

  def get_registration(pid, plot_id) do
    case Agent.get(pid, fn {_, regs} -> Enum.find(regs, & &1.plot_id == plot_id) end) do
      nil -> {:not_found, "plot is unregistered"}
      plot -> plot
    end
  end
end
