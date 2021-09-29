import Config

config :ftx_lending_bot, FtxLendingBot.Scheduler,
  # Reference: https://github.com/quantum-elixir/quantum-core
  jobs: [
    {"*/15 * * * *", {FtxLendingBot.Lender, :call, []}}
  ]
