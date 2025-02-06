import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: SandshellApi.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

config :sandshell_api, SandshellApi.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  server: true,
  http: [ip: {127, 0, 0, 1}, port: 5500],
  url: [host: "sandshell.dev", port: 80],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "9AZVzPMDZqZI/VS4FIJ+jtmLymK+W2WN3SClBXpKZShv6eF/PaZbVhX6sc3fzK7f",
  watchers: []

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
