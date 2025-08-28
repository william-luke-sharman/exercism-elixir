defmodule Username do

  def sanitize([]), do: []
  
  def sanitize([h | t]) do
    case h do
      x when x in ?a..?z -> [h | sanitize(t)]
      ?_ -> [h | sanitize(t)]
      ?ä -> ~c"ae" ++ sanitize(t)
      ?ö -> ~c"oe" ++ sanitize(t)
      ?ü -> ~c"ue" ++ sanitize(t)
      ?ß -> ~c"ss" ++ sanitize(t)
      _ -> sanitize(t)
    end
  end

end
