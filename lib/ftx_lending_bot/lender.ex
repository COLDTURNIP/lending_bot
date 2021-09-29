defmodule FtxLendingBot.Lender do
  use GenServer

  # Callbacks

  @impl true
  def init(config) do
    {:ok, config}
  end

  @impl true
  def handle_call(:trigger, _from, config) do
    {:reply, trigger_refill(config), config}
  end

  defp trigger_refill(config) do
    %ExFtx.Credentials{
      api_key: config.key,
      api_secret: config.secret,
      sub_account: config.subaccount
    }
    |> FtxLendingBot.Lending.refill_lending()
  end

  # client

  def start_link(config) do
    GenServer.start_link(__MODULE__, config, name: __MODULE__)
  end

  def call(), do: GenServer.call(__MODULE__, :trigger)
end
