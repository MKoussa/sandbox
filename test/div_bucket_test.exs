defmodule DivBucketTest do
  use ExUnit.Case, async: true

  setup do
    divBucket = start_supervised!(DivBucket)
    %{divBucket: divBucket}
  end

  test "stores div answers by equation", %{divBucket: divBucket} do
    assert DivBucket.get(divBucket, {5,5}) == nil

    DivBucket.put(divBucket, {5,5}, Division.safediv(5,5))
    assert DivBucket.get(divBucket, {5,5}) == 1
  end

  test "deletes div answers by equation key", %{divBucket: divBucket} do
    assert DivBucket.get(divBucket, {4,4}) == nil

    DivBucket.put(divBucket, {4,4}, Division.safediv(4,4))
    assert DivBucket.get(divBucket, {4,4}) == 1

    DivBucket.delete(divBucket, {4,4})
    assert DivBucket.get(divBucket, {4,4}) == nil
  end
end
