defmodule Server.Supervisor do
  use Supervisor
  require Logger

  def start_link() do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    Process.flag(:trap_exit, true)

    children = [
      %{id: :prod_server, start: {Server, :init, [{{0, 0, 0, 0}, 6666}]}},
      %{id: :cons_server, start: {Server, :init, [{{0, 0, 0, 0}, 6667}]}}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
