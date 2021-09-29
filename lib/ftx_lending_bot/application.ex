defmodule FtxLendingBot.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    config = Vapor.load!(FtxLendingBot.Config)

    children = [
      FtxLendingBot.Scheduler,
      {FtxLendingBot.Lender, config.ftx}
    ]

    opts = [strategy: :one_for_one, name: FtxLendingBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
