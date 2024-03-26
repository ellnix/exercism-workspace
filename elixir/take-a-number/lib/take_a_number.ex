defmodule TakeANumber do
  def start() do
    spawn(&take_a_number/0)
  end

  defp take_a_number(counter \\ 1) do
    receive do
      {:report_state, pid} ->
        send(pid, counter - 1)
        take_a_number(counter)
      {:take_a_number, pid} ->
        send(pid, counter)
        take_a_number(counter + 1)
      :stop -> :nothing
      _ -> take_a_number(counter)
    end
  end
end
