# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Phrampu.Repo.insert!(%Phrampu.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
NimbleCSV.define(CSV, separator: ":", escape: ~s("))

alias Phrampu.Student
alias Phrampu.Host
alias Phrampu.Cluster
alias Phrampu.Who

Phrampu.Repo.delete_all(Student)
Phrampu.Repo.delete_all(Host)
Phrampu.Repo.delete_all(Cluster)
Phrampu.Repo.delete_all(Who)

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
		 Phrampu.Repo.insert!(changeset)
		end)

Application.get_env(:phrampu, :clusters)
	|> Enum.each(fn %{hosts: hosts, name: name, room: room} -> 
    cluster_changeset = Cluster.changeset(%Cluster{}, %{
      name: name,
      room: room
    })
    cluster = Phrampu.Repo.insert!(cluster_changeset)
    hosts |>
      Enum.each(fn host ->
        host_changeset = Host.changeset(%Host{}, %{
          name: host,
          cluster_id: cluster.id
        })
        Phrampu.Repo.insert!(host_changeset)
      end)
  end)

