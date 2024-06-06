defmodule DivRegistry do
  use GenServer

  # Client
  @doc"""
  Starts the registry
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc"""
  Looks up the bucket pid for `name` stored in `server`
  Returns `{:ok, pid}` if the buckets exists, `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc"""
  Ensures there is a bucket associated with the given `name` in the `server`.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  # Callbacks

  @impl true
  def init(:ok) do
    divState = %{}
    refs = %{}
    {:ok, {divState, refs}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {divState, _} = state
    {:reply, Map.fetch(divState, name), state}
  end

  @impl true
  def handle_cast({:create, name}, {divState, refs}) do
    if Map.has_key?(divState, name) do
      {:noreply, {divState, refs}}
    else
      {:ok, divBucket} = DivBucket.start_link([])
      ref = Process.monitor(divBucket)
      refs = Map.put(refs, ref, name)
      divState = Map.put(divState, name, divBucket)
      {:noreply, {divState, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {divState, refs}) do
    {name, refs} = Map.pop(refs,ref)
    divState = Map.delete(divState, name)
    {:noreply, {divState, refs}}
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected message in DivRegistry: #{inspect(msg)}")
    {:noreply, state}
  end

end
