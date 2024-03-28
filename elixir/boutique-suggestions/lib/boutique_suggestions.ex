# %{
#   item_name: "Descriptive Name",
#   price: 99.00,
#   base_color: "red"
# }

defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100)
    for top <- tops, bot <- bottoms, 
      top.base_color != bot.base_color,
      top.price + bot.price < max_price do 
      {top, bot}
    end
  end
end
