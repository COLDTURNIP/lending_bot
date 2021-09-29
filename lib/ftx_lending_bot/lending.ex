defmodule FtxLendingBot.Lending do
  @type credentials :: ExFtx.Credentials
  @type result :: :ok | {:error, String.t()}

  @spec refill_lending(credentials) :: [result]
  def refill_lending(credentials) do
    with rates <- lending_rate(),
         status <- lending_status(credentials) do
      Enum.filter_map(
        status,
        fn lended -> Map.has_key?(rates, lended.coin) end,
        fn lended ->
          {
            lended.coin,
            Float.floor(lended.lendable, 8),

            # ensure submit rate can lending success
            Map.get(rates, lended.coin) * 0.6
          }
        end
      )
    end
    |> Enum.map(fn {coin, size, rate} -> gen_payload(coin, size, rate) end)
    |> Enum.map(fn payload -> ExFtx.SpotMargin.Create.post(credentials, payload) end)
  end

  defp lending_rate() do
    ExFtx.SpotMargin.LendingRates.get()
    |> then(fn {:ok, list} -> list end)
    |> Map.new(fn rate -> {rate.coin, rate.estimate} end)
  end

  defp lending_status(credentials) do
    {:ok, info_list} = ExFtx.SpotMargin.LendingInfo.get(credentials)
    info_list
  end

  defp gen_payload(coin, size, rate) do
    IO.inspect(%ExFtx.LendingPayload{
      coin: coin,
      size: size,
      rate: rate
    })
  end
end
