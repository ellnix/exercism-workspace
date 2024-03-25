# | Condition                                                     | Response       |
# | ------------------------------------------------------------- | -------------- |
# | When the guess matches the secret number                      | "Correct"      |
# | When the guess is one more or one less than the secret number | "So close"     |
# | When the guess is greater than the secret number              | "Too high"     |
# | When the guess is less than the secret number                 | "Too low"      |
# | When a guess isn't made                                       | "Make a guess" |

defmodule GuessingGame do
  def compare(_secret_number, guess) when not is_integer(guess), do: "Make a guess"
  def compare(secret_number, guess) when secret_number == guess, do: "Correct"
  def compare(secret_number, guess) when abs(secret_number - guess) < 2, do: "So close"
  def compare(secret_number, guess) when secret_number > guess, do: "Too low"
  def compare(secret_number, guess) when secret_number < guess, do: "Too high"
  def compare(_secret_number), do: "Make a guess"
end
