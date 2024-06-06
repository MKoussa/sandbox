defmodule DivStack do
  use GenServer, id: :divStackId

  # Client

  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default)
  end

  #Async
  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  #Synchronous
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server Callbacks

  @impl true
  def init(elements) do
    initial_state = elements
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [to_caller | new_state] = state
    {:reply, to_caller, new_state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    new_state = [element | state]
    {:noreply, new_state}
  end
end
