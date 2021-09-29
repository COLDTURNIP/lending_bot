defmodule FtxLendingBotTest do
  use ExUnit.Case
  doctest FtxLendingBot

  test "greets the world" do
    assert FtxLendingBot.hello() == :world
  end
end
