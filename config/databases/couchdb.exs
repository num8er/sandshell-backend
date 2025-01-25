import Config

config :sandshell, :couchdb,
  host: "127.0.0.1",
  port: 5984,
  username: "sandshell",
  password: "sandshell",
  database: "sandshell"

config :sandshell_api, :couchdb_pool,
  name: {:local, :couchdb_pool},
  worker_module: Sandshell.Database.PoolWorker,
  size: 10,
  max_overflow: 5
