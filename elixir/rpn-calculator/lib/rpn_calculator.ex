defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      { :ok, calculate!(stack, operation) }
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      { :ok, calculate!(stack, operation) }
    rescue
      error -> { :error, error.message }
    end
  end
end
