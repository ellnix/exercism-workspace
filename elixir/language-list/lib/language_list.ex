defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    [_head | tail] = list
    tail
  end

  def first(list) do
    [head | _tail] = list
    head
  end


  def count([]) do
    0
  end

  def count(list) do
    count(remove(list)) + 1
  end

  def functional_list?([]) do
    false
  end

  def functional_list?(list) do
    [head | tail] = list

    case head do
      "Elixir" -> true
      _ -> functional_list?(tail)
    end
  end
end
