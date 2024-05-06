defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_keep(list, fun, [])
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_keep(list, &(!fun.(&1)), [])
  end

  defp do_keep([], _fun, acc), do: Enum.reverse(acc)
  defp do_keep([item | rest], fun, acc) do
    if fun.(item) do
      do_keep(rest, fun, [item | acc])
    else
      do_keep(rest, fun, acc)
    end
  end

end
