defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {:def, _, [{:when, _, [func | _] } | _]} -> { ast, [fun_to_secret(func) | acc]}
      {:defp, _, [{:when, _, [func | _] } | _]} -> { ast, [fun_to_secret(func) | acc]}
      {:def, _, [func | _]} -> { ast, [fun_to_secret(func) | acc]}
      {:defp, _, [func | _]} -> { ast, [fun_to_secret(func) | acc]}
      _ -> { ast, acc }
    end
  end

  defp fun_to_secret({name, _, args}) do
    case args do
      [] -> ""
      nil -> ""
      _ -> 
        chars = 0..(Enum.count(args) - 1)
        name
        |> to_string()
        |> String.slice(chars)
    end
  end

  def decode_secret_message(string) do
    full_ast = to_ast(string)

    definitions = case full_ast do
      {:__block__, _, code_in_block} ->
        with [{:defmodule, _, _} | _] <- code_in_block do
          code_in_block
          |> Enum.map(&module_funcs/1)
          |> Enum.concat()
        else
          _ -> code_in_block
        end
      {:defmodule, _, _} -> module_funcs(full_ast)
    end

    definitions
    |> Enum.reduce([], fn ast, acc -> decode_secret_message_part(ast, acc) |> elem(1) end)
    |> Enum.reverse
    |> Enum.join()
  end

  defp module_funcs(ast) do
    case ast do
      {:defmodule, _, [_aliases, [do: {:__block__, _, defs}]]} -> defs
      {:defmodule, _, [_aliases, [do: def]]} -> [def]
    end
  end
end
