defmodule DivisionTest do
  use ExUnit.Case
  doctest Division

  test "safe division is safe" do
    assert Division.safediv(2, 0) == 0
    assert Division.safediv(0, 0) == 0
    assert Division.safediv(2, 4) == 0.5
    assert Division.safediv(2, -4) == -0.5
  end
end
