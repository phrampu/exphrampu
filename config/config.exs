# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phrampu,
  ecto_repos: [Phrampu.Repo],
  clusters: [
    %{
      name: "etc",
      room: "N/A",
      hosts:
      ["data.cs.purdue.edu"]
    },
    %{
      name: "xinu",
      room: "HAAS 257",
      hosts:
        ["xinu01.cs.purdue.edu",
        "xinu02.cs.purdue.edu",
        "xinu03.cs.purdue.edu",
        "xinu04.cs.purdue.edu",
        "xinu05.cs.purdue.edu",
        "xinu06.cs.purdue.edu",
        "xinu07.cs.purdue.edu",
        "xinu08.cs.purdue.edu",
        "xinu09.cs.purdue.edu",
        "xinu10.cs.purdue.edu",
        "xinu11.cs.purdue.edu",
        "xinu12.cs.purdue.edu",
        "xinu13.cs.purdue.edu",
        "xinu14.cs.purdue.edu",
        "xinu15.cs.purdue.edu",
        "xinu16.cs.purdue.edu",
        "xinu17.cs.purdue.edu",
        "xinu18.cs.purdue.edu",
        "xinu19.cs.purdue.edu",
        "xinu20.cs.purdue.edu",
        "xinu21.cs.purdue.edu"]
    },
    %{
      name: "borg",
      room: "HAAS G040",
      hosts:
        ["borg01.cs.purdue.edu",
        "borg02.cs.purdue.edu",
        "borg03.cs.purdue.edu",
        "borg04.cs.purdue.edu",
        "borg05.cs.purdue.edu",
        "borg06.cs.purdue.edu",
        "borg07.cs.purdue.edu",
        "borg08.cs.purdue.edu",
        "borg09.cs.purdue.edu",
        "borg10.cs.purdue.edu",
        "borg11.cs.purdue.edu",
        "borg12.cs.purdue.edu",
        "borg13.cs.purdue.edu",
        "borg14.cs.purdue.edu",
        "borg15.cs.purdue.edu",
        "borg16.cs.purdue.edu",
        "borg17.cs.purdue.edu",
        "borg18.cs.purdue.edu",
        "borg19.cs.purdue.edu",
        "borg20.cs.purdue.edu",
        "borg21.cs.purdue.edu",
        "borg22.cs.purdue.edu",
        "borg23.cs.purdue.edu",
        "borg24.cs.purdue.edu"]
    },
    %{
      name: "moore",
      room: "LWSN B146",
      hosts: 
        ["moore00.cs.purdue.edu",
        "moore01.cs.purdue.edu",
        "moore02.cs.purdue.edu",
        "moore03.cs.purdue.edu",
        "moore04.cs.purdue.edu",
        "moore05.cs.purdue.edu",
        "moore06.cs.purdue.edu",
        "moore07.cs.purdue.edu",
        "moore08.cs.purdue.edu",
        "moore09.cs.purdue.edu",
        "moore10.cs.purdue.edu",
        "moore11.cs.purdue.edu",
        "moore12.cs.purdue.edu",
        "moore13.cs.purdue.edu",
        "moore14.cs.purdue.edu",
        "moore15.cs.purdue.edu",
        "moore16.cs.purdue.edu",
        "moore17.cs.purdue.edu",
        "moore18.cs.purdue.edu",
        "moore19.cs.purdue.edu",
        "moore20.cs.purdue.edu",
        "moore21.cs.purdue.edu",
        "moore22.cs.purdue.edu",
        "moore23.cs.purdue.edu",
        "moore24.cs.purdue.edu"]
    },
    %{
      name: "pod",
      room: "LWSN B148",
      hosts:
        ["pod0-0.cs.purdue.edu",
        "pod1-1.cs.purdue.edu",
        "pod1-2.cs.purdue.edu",
        "pod1-3.cs.purdue.edu",
        "pod1-4.cs.purdue.edu",
        "pod1-5.cs.purdue.edu",
        "pod2-1.cs.purdue.edu",
        "pod2-2.cs.purdue.edu",
        "pod2-3.cs.purdue.edu",
        "pod2-4.cs.purdue.edu",
        "pod2-5.cs.purdue.edu",
        "pod3-1.cs.purdue.edu",
        "pod3-2.cs.purdue.edu",
        "pod3-3.cs.purdue.edu",
        "pod3-4.cs.purdue.edu",
        "pod3-5.cs.purdue.edu",
        "pod4-1.cs.purdue.edu",
        "pod4-2.cs.purdue.edu",
        "pod4-3.cs.purdue.edu",
        "pod4-4.cs.purdue.edu",
        "pod4-5.cs.purdue.edu",
        "pod5-1.cs.purdue.edu",
        "pod5-2.cs.purdue.edu",
        "pod5-3.cs.purdue.edu",
        "pod5-4.cs.purdue.edu",
        "pod5-5.cs.purdue.edu"]
    },
    %{
      name: "sslab",
      room: "LWSN B158",
      hosts:
        ["sslab00.cs.purdue.edu",
        "sslab01.cs.purdue.edu",
        "sslab02.cs.purdue.edu",
        "sslab03.cs.purdue.edu",
        "sslab04.cs.purdue.edu",
        "sslab05.cs.purdue.edu",
        "sslab06.cs.purdue.edu",
        "sslab07.cs.purdue.edu",
        "sslab08.cs.purdue.edu",
        "sslab09.cs.purdue.edu",
        "sslab10.cs.purdue.edu",
        "sslab11.cs.purdue.edu",
        "sslab12.cs.purdue.edu",
        "sslab13.cs.purdue.edu",
        "sslab14.cs.purdue.edu",
        "sslab15.cs.purdue.edu",
        "sslab16.cs.purdue.edu",
        "sslab17.cs.purdue.edu",
        "sslab18.cs.purdue.edu",
        "sslab19.cs.purdue.edu",
        "sslab20.cs.purdue.edu",
        "sslab21.cs.purdue.edu",
        "sslab22.cs.purdue.edu",
        "sslab23.cs.purdue.edu",
        "sslab24.cs.purdue.edu"]
    },
    %{
      name: "escher",
      room: "HAAS G056",
      hosts:
        ["escher00.cs.purdue.edu",
        "escher01.cs.purdue.edu",
        "escher02.cs.purdue.edu",
        "escher03.cs.purdue.edu",
        "escher04.cs.purdue.edu",
        "escher05.cs.purdue.edu",
        "escher06.cs.purdue.edu",
        "escher07.cs.purdue.edu",
        "escher08.cs.purdue.edu",
        "escher09.cs.purdue.edu",
        "escher10.cs.purdue.edu",
        "escher11.cs.purdue.edu",
        "escher12.cs.purdue.edu",
        "escher13.cs.purdue.edu",
        "escher14.cs.purdue.edu",
        "escher15.cs.purdue.edu",
        "escher16.cs.purdue.edu",
        "escher17.cs.purdue.edu",
        "escher18.cs.purdue.edu",
        "escher19.cs.purdue.edu",
        "escher20.cs.purdue.edu",
        "escher21.cs.purdue.edu",
        "escher22.cs.purdue.edu",
        "escher23.cs.purdue.edu"]
    }
  ]

# Configures the endpoint
config :phrampu, Phrampu.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fHv0m2un0ms0Q3byIZ751UvvHS71CahwBbQktEAKC5JkcuJb1QOY/Jfar1EJYr7d",
  render_errors: [view: Phrampu.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Phrampu.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
