# If the dart lands outside the target, player earns no points (0 points).
# If the dart lands in the outer circle of the target, player earns 1 point.
# If the dart lands in the middle circle of the target, player earns 5 points.
# If the dart lands in the inner circle of the target, player earns 10 points.

defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    dist = x * x + y * y

    cond do
      dist <=   1 -> 10
      dist <=  25 ->  5
      dist <= 100 ->  1
      true        ->  0
    end
  end
end
