defmodule DataStructureEx do
  @moduledoc """
  Documentation for DataStructureEx.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DataStructureEx.hello()
      :world

  """
  def hello do
    :world
  end

  def test_tree do
    arr =
      1..10_000_000
      |> Enum.to_list
      |> Enum.shuffle

    IO.inspect arr

    :timer.tc(fn -> Enum.member?(arr, 5_000_000) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect

    :timer.tc(fn -> DataStructureEx.Tree.from_list(arr) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect

    tree = DataStructureEx.Tree.from_list(arr)
    :timer.tc(fn -> DataStructureEx.Tree.member?(tree, 5_000_000) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect
  end
  def test_tree_not_found do
    arr =
      1..10_000_000
      |> Enum.to_list
      |> Enum.shuffle

    IO.inspect arr

    :timer.tc(fn -> Enum.member?(arr, 10_000_001) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect

    tree = DataStructureEx.Tree.from_list(arr)
    :timer.tc(fn -> DataStructureEx.Tree.member?(tree, 10_000_001) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect
  end

  def test_red_black_tree do
    arr =
      1..10_000_000
      |> Enum.to_list
      |> Enum.shuffle

    :timer.tc(fn -> Enum.member?(arr, 5_000_000) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect

    :timer.tc(fn -> DataStructureEx.RedBlackTree.from_list(arr) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect

    tree = DataStructureEx.RedBlackTree.from_list(arr)
    :timer.tc(fn -> DataStructureEx.RedBlackTree.member?(tree, 5_000_000) end)
    |> elem(0)
    |> Kernel./(1_000_000)
    |> IO.inspect
  end
end
