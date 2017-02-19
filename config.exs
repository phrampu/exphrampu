config :quantum, :your_app,
  cron: [
    "*/20 * * * *":      {"Jank", :update},
  ]
