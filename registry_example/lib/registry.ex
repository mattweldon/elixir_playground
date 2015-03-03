defmodule RegistryExample.Registry do
  use GenServer

  # -- Client

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, options)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end


  # -- Server

  def init([]) do
    { :ok, HashDict.new }
  end

  def handle_call({:lookup, name}, _from, names) do
    {:reply, HashDict.fetch(names, name), names}
  end

  def handle_cast({:create, name}, names) do
    if HashDict.has_key?(names, name) do
      {:noreply, names} # Name already exists so keep the list as-is
    else
      # Create a new bucket
      {:ok, bucket} = RegistryExample.Bucket.start_link

       # Add the bucket to the server under the given name
      {:noreply, HashDict.put(names, name, bucket)}
    end
  end

end
