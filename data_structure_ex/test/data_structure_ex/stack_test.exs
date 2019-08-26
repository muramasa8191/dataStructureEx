defmodule Stack.Test do
  use ExUnit.Case
  doctest DataStructureEx.Stack

  test "count zero" do
    stack = %DataStructureEx.Stack{}
    assert Enum.count(stack) == 0
  end

  test "count" do
    stack = %DataStructureEx.Stack{data: [3, 2, 1]}
    assert Enum.count(stack) == 3
  end

  test "member contains" do
    stack = %DataStructureEx.Stack{data: [3, 2, 1]}
    assert Enum.member?(stack, 3)
  end

  test "member not contains" do
    stack = %DataStructureEx.Stack{data: [3, 2, 1]}
    assert not Enum.member?(stack, 4)
  end

  test "Enum.map" do
    stack = %DataStructureEx.Stack{}

    stack = DataStructureEx.Stack.cons(stack, 1)
    stack = DataStructureEx.Stack.cons(stack, 2)
    stack = DataStructureEx.Stack.cons(stack, 3)

    assert Enum.map(stack, &(&1 * &1)) == [9, 4, 1]
  end

end