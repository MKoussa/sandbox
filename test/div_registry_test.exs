defmodule DivRegistryTest do
  use ExUnit.Case, async: true

  setup do
    divRegistry = start_supervised!(DivRegistry)
    %{divRegistry: divRegistry}
  end

  test "spawn buckets", %{divRegistry: divRegistry} do
    assert DivRegistry.lookup(divRegistry, "divBucket") == :error

    DivRegistry.create(divRegistry, "divBucket")
    assert {:ok, divBucket} = DivRegistry.lookup(divRegistry, "divBucket")

    DivBucket.put(divBucket, {44,55}, Division.safediv(44,55))
    assert DivBucket.get(divBucket, {44,55}) == 0.8
  end

  test "removes bucket on exit", %{divRegistry: divRegistry} do
    DivRegistry.create(divRegistry, {5,6})
    {:ok, divBucket} = DivRegistry.lookup(divRegistry, {5,6})
    Agent.stop(divBucket)
    assert DivRegistry.lookup(divRegistry, {5,6}) == :error
  end
end
