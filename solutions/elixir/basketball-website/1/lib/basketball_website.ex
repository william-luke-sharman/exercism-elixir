defmodule BasketballWebsite do

  def extract_from_path(data, path), do: do_extract_from_path(data, String.split(path, "."))

  defp do_extract_from_path(data, []), do: data

  defp do_extract_from_path(data, [h | t]), do: do_extract_from_path(data[h], t)

  def get_in_path(data, path), do: Kernel.get_in(data, String.split(path, "."))
end
