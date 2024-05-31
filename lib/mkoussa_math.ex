defmodule MKoussaMath do
  @moduledoc """
  Documentation for MKoussa's wild-n-wonky Math"

  ## Examples
      iex> MKoussaMath.safediv(2,4)
      0.5
  """

  @doc """
  Safe Division

  ## Examples
      iex> MKoussaMath.safediv(2,4)
      0.5
      iex> MKoussaMath.safediv(2,0)
      0
      iex> MKoussaMath.safediv(2,-4)
      -0.5
  """
  def safediv(0), do: 0
  def safediv(_a, 0), do: 0
  def safediv(0, 0), do: 0
  def safediv(a, b) do
    unsafediv(a, b)
  end

  defp unsafediv(a, b) do
    a / b
  end
end
