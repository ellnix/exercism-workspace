defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception [message: "division by zero occurred"]
  end

  defmodule StackUnderflowError do
    defexception [message: "stack underflow occurred"]

    @impl true
    def exception(term) do
      case term do
        [] -> %StackUnderflowError{}
        term -> %StackUnderflowError{ message: "stack underflow occurred, context: " <> term}
      end
    end
  end

  def divide(numbers) do
    case numbers do
      [0, _b] -> raise DivisionByZeroError
      [a, b] -> b / a
      _ -> raise StackUnderflowError, "when dividing"
    end
  end
end
