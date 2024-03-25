defmodule Username do
  def sanitize([]), do: []
  def sanitize(username) do
    [first | rest] = username

    sanitized = case first do
      x when x >= ?a and x <= ?z -> [x]
      ?_ -> [?_]
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> false
    end

    if sanitized do
      sanitized ++ sanitize(rest)
    else
      sanitize(rest)
    end
  end
end
