config :quantum, :your_app,
  cron: [
    "*/30 * * * *":      {"Jank", :update},
  ]
