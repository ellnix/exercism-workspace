defmodule NameBadge do
  def print(id, name, department) do
    id = if id, do: "[#{id}] - ", else: ""
    id <> "#{name} - #{String.upcase(department || "OWNER")}"
  end
end
