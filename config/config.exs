# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :chatbot,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :chatbot, ChatbotWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: ChatbotWeb.ErrorHTML, json: ChatbotWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Chatbot.PubSub,
  live_view: [signing_salt: "lFsr9DQX"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
    ~w(app/js/app.js chatbot/js/app.js chatbot/js/launcher.js --bundle --target=es2017 --outdir=../priv/static/frontend --external:/fonts/* --external:/images/*),
    cd: Path.expand("../frontend", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Move the launch script to static dir so that it can be served with: https://site.com/launcher.js
config :phoenix_copy,
chatbot: [
  source: Path.expand("../priv/static/frontend/chatbot/js/launcher.js", __DIR__),
  destination: Path.expand("../priv/static/launcher.js", __DIR__),
  debounce: 100
]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  app: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../../priv/static/frontend/app/css/app.css
    ),
    cd: Path.expand("../frontend/app", __DIR__)
  ],
  chatbot: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../../priv/static/frontend/chatbot/css/app.css
    ),
    cd: Path.expand("../frontend/chatbot", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
