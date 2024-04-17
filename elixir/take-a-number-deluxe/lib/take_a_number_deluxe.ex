defmodule TakeANumberDeluxe do
  # Client API
  use GenServer

  alias TakeANumberDeluxe.State

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    min = Keyword.get(init_arg, :min_number)
    max = Keyword.get(init_arg, :max_number)
    shutdown = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)

    case State.new(min, max, shutdown) do
      {:ok, state} -> GenServer.start_link(__MODULE__, state)
      other -> other
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :next_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
    :ok
  end

  # Server callbacks

  @impl GenServer
  def init(state) do
    {:ok, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:next_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, n, new_state} -> {:reply, {:ok, n}, new_state, state.auto_shutdown_timeout}
      other -> {:reply, other, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_number, priority}, _from, state) do
    case State.serve_next_queued_number(state, priority) do
      {:ok, n, new_state} -> {:reply, {:ok, n}, new_state, state.auto_shutdown_timeout}
      other -> {:reply, other, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    { :noreply,
      %State{ state | queue: TakeANumberDeluxe.Queue.new() },
      state.auto_shutdown_timeout }
  end

  @impl GenServer
  def handle_info(:timeout, _state) do
    Process.exit(self(), :normal)
  end

  @impl GenServer
  def handle_info(_message, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
