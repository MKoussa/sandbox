defmodule DivStackTest do
  use ExUnit.Case, async: true

  setup do
    divStack = start_supervised!(DivStack)
    %{divStack: divStack}
  end

  test "push and pop by equation", %{divStack: divStack} do
    DivStack.push(divStack, Division.safediv(4,8))
    assert DivStack.pop(divStack) == 0.5
  end


end
