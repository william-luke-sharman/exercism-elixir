defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    combinations = for top <- tops, bottom <- bottoms do
      {top, bottom}
    end

    combinations = for {top, bottom} <- combinations, top.base_color != bottom.base_color do
      {top, bottom}
    end

    for {top, bottom} <- combinations, top.price + bottom.price < Keyword.get(options, :maximum_price, 100)  do
      {top, bottom}
    end
  end
end
