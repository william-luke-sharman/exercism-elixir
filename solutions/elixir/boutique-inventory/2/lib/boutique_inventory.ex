defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price === nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &update_name(&1, old_word, new_word))
  end

  defp update_name(item, old_word, new_word) do
    Map.update!(item, :name, &String.replace(&1, old_word, new_word))
  end

  def increase_quantity(item, count) do
    new_quantity_by_size = 
      item.quantity_by_size
      |> Map.new(fn {key, val} -> {key, val + count} end)

    Map.put(item, :quantity_by_size, new_quantity_by_size)
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn {_key, val}, acc -> acc + val end)
  end
end
