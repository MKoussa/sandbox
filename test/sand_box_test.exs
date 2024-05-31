defmodule SandBoxTest do
  use ExUnit.Case
  doctest SandBox

  test "greets the world" do
    assert SandBox.hello() == :world
  end
end
