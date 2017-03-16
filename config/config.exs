use Mix.config

config :phrampu, master_node: :"cody@127.0.0.1"

config :phrampu, slave_nodes: [:"borg@127.0.0.1",
                              :"moore@127.0.0.1",
                              :"pod@127.0.0.1"]
