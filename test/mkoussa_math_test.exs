defmodule MKoussaMathTest do
  use ExUnit.Case
  doctest MKoussaMath

  test "safe division is safe" do
    assert MKoussaMath.safediv(2,0) == 0
    assert MKoussaMath.safediv(0,0) == 0
    assert MKoussaMath.safediv(2,4) == 0.5
    assert MKoussaMath.safediv(2,-4) == -0.5
  end
end
