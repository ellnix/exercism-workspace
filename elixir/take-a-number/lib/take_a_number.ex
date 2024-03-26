defmodule TakeANumber do
  def start() do
    spawn(fn -> send_next_number() end)
  end

  defp send_next_number(counter \\ 1) do
    receive do
      {:report_state, pid} ->
        send(pid, counter - 1)
        send_next_number(counter)
      {:take_a_number, pid} ->
        send(pid, counter)
        send_next_number(counter + 1)
      :stop -> :nothing
      _ -> send_next_number(counter)
    end
  end
end
