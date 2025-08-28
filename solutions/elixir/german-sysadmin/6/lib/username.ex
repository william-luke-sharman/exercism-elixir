defmodule Username do

  def sanitize([]), do: []
  
  def sanitize([h | t]), do: sanitize_character(h) ++ sanitize(t)
  
  defp sanitize_character(char) do
    case char do
      x when x in ?a..?z -> [char]
      ?_ -> ~c"_"
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> ~c""
    end
  end

end
