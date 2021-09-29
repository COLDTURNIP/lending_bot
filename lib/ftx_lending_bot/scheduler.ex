defmodule FtxLendingBot.Scheduler do
  use Quantum, otp_app: :ftx_lending_bot

  def heartbeat(), do: IO.puts("heartbeat #{inspect(Time.utc_now())}")
end
