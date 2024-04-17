defmodule LogParser do
  @spec valid_line?(String.t()) :: boolean()
  def valid_line?(line) do
    validity_checker = ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
    line =~ validity_checker
  end

  @spec split_line(String.t()) :: [String.t()]
  def split_line(line) do
    ~r/\<[=\-~*]*\>/
    |> Regex.split(line)
  end

  @spec remove_artifacts(String.t()) :: String.t()
  def remove_artifacts(line) do
    ~r/end-of-line\d+/i
    |> Regex.replace(line, "")
  end

  @spec tag_with_user_name(String.t()) :: String.t()
  def tag_with_user_name(line) do
    user_finder = ~r/User\s+(\S+)/u

    with [_, username] <- Regex.run(user_finder, line) do
      "[USER] #{username} " <> line
    else
      _ -> line
    end
  end
end
