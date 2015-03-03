defmodule RegistryExample.Bucket do
  use GenServer

  # -- Client

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, options)
  end

  # -- Server

end