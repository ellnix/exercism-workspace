defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    with {:ok, pid } <- Task.start_link(fn -> calculator.(input) end) do
      %{input: input, pid: pid}
    end
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    result = receive do
      {:EXIT, ^pid, :normal} -> :ok
      {:EXIT, ^pid, _} -> :error
      after 100 -> :timeout
    end

    Map.put(results, input, result)
  end

  def reliability_check(calculator, inputs) do
    old_trap = Process.flag(:trap_exit, true)
    result = check_reliability(calculator, inputs)
    Process.flag(:trap_exit, old_trap)

    result
  end

  defp check_reliability(_, []), do: %{}
  defp check_reliability(calculator, [input | rest]) do
    await_reliability_check_result(
      start_reliability_check(calculator, input),
      check_reliability(calculator, rest)
    )
  end

  def correctness_check(_, []), do: []
  def correctness_check(calculator, [input | rest]) do
    task = Task.async(fn -> calculator.(input) end)
    other_results = correctness_check(calculator, rest)
    [Task.await(task, 100) | other_results]
  end
end
