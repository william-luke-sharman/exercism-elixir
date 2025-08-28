defmodule NameBadge do
  def print(id, name, department) do
   prefix = if id, do: "[#{id}] - ", else: ""
   department = if department, do: department, else: "OWNER"
   prefix <> "#{name} - #{String.upcase(department)}"
  end

end
