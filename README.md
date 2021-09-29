# Raphanus' Lending Bot

## Build

```bash
mix deps.get
MIX_ENV=prod mix release

# or containerize
podman build -t raphanus-lending-bot .
```

## Configuration

### Runtime configurations

Config by environment variables

- `FTX_KEY`: FTX API key
- `FTX_SECRET`: FTX API secret
- `FTX_SUBACCOUNT`: (optional) FTX subaccount

### Compile time configurations

In `config/config.exs`:

```elixir
config :ftx_lending_bot, FtxLendingBot.Scheduler,
  # Reference: https://github.com/quantum-elixir/quantum-core
  jobs: [
    # Refresh lending offers every 15 minutes
    {"*/15 * * * *", {FtxLendingBot.Lender, :call, []}}
  ]
```
