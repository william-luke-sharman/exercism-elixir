defmodule Username do

  def sanitize(username), do: sanitize(username, [])

  defp sanitize([], username), do: Enum.reverse(username)
  
  defp sanitize([h | t], username) do
    case h do
      h when h in ?a..?z -> sanitize(t, [h | username])
      ^h = ?_ -> sanitize(t, [h | username])
      ^h = ?ä -> sanitize(t, ~c"ea" ++ username)
      ^h = ?ö -> sanitize(t, ~c"eo" ++ username)
      ^h = ?ü -> sanitize(t, ~c"eu" ++ username)
      ^h = ?ß -> sanitize(t, ~c"ss" ++ username)
      _ -> sanitize(t, username)
    end
  end
end
