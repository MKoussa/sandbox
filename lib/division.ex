defmodule Division do
  @moduledoc """
  Documentation for MKoussa's wild-n-wonky Math"

  ## Examples
      iex> Division.safediv(2,4)
      0.5
  """

  @doc """
  Safe Division

  ## Examples
      iex> Division.safediv(2,4)
      0.5
      iex> Division.safediv(2,0)
      0
      iex> Division.safediv(2,-4)
      -0.5
  """
  def safediv(_a, 0), do: 0
  def safediv(0, 0), do: 0

  def safediv(a, b) do
    unsafediv(a, b)
  end

  defp unsafediv(a, b) do
    a / b
  end

  def start_link do
    Task.start_link(fn -> divLoop() end)
  end

  defp divLoop() do
    receive do
      {:safeDiv, caller, a, b} ->
        send(caller, {:ok, safediv(a, b)})
        divLoop()

      {:safeDivAndStore, caller, db, a, b} ->
        answer = safediv(a, b)
        DivBucket.put(db, "#{a} / #{b}", answer)
        send(caller, {:ok, answer})
        divLoop()
    end
  end
end
