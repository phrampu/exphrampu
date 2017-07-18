NimbleCSV.define(CSV, separator: ":", escape: ~s("))

defmodule Phrampu.Build do
  alias Phrampu.Student

  def build do
    "lname.db"
			|> File.stream!
			|> CSV.parse_stream
			|> Enum.map(fn [career_acc, name, email, machine | _] -> 
				%{career_acc: career_acc, 
					name: name |> String.split(",") |> List.first(), 
					email: email, 
					machine: machine} 
			end)
			|> Enum.each(fn params ->
				changeset = Student.changeset(%Student{}, params)
				Phrampu.Repo.insert(changeset)
			end)
  end

end
