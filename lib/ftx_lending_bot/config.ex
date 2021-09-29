defmodule FtxLendingBot.Config do
  use Vapor.Planner

  dotenv()

  config :ftx,
         env([
           {:key, "FTX_KEY", default: ""},
           {:secret, "FTX_SECRET", default: ""},
           {:subaccount, "FTX_SUBACCOUNT", default: nil}
         ])
end
