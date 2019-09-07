defmodule DataStructureEx.RedBlackTree do
  @moduledoc """
  The Red Black Tree operation based on the list generated 
  by the DataStructureEx.RedBlackTree.insert(value, []) function
  and modified by the functions in DataStructureEx.RedBlackTree module.
  """

  @doc """
  Check whether the given value is in the tree or not.

  ## Examples
    iex> DataStructureEx.RedBlackTree.member?(10, [])
    false

    iex> DataStructureEx.RedBlackTree.member?(10, [:red, [], 10, []])
    true

    iex> DataStructureEx.RedBlackTree.member?(10, [:red, [:black, [], 10, []], 20, [:black, [], 30, []]])
    true

    iex> DataStructureEx.RedBlackTree.member?(10, [:red, [:black, [], 1, []], 5, [:black, [], 10, []]])
    true

  """
  def member?(x, tree) do
    member?(x, tree, &(&1 < &2), &(&1 == &2))
  end

  @doc """
  Check the value given is in the tree or not with the comparator

  ## Examples 
    iex> DataStructureEx.RedBlackTree.member?(10, [], &(&1 > &2), &(&1 == &2))
    false

    iex> DataStructureEx.RedBlackTree.member?(10, [:red, [:black, [], 30, []], 20, [:black, [], 10, []]], &(&1 > &2), &(&1 == &2))
    true

  """
  def member?(_, [], _, _) do
    false
  end
  def member?(x, [_ , a , y , b], lt, eq) do
    if eq.(x, y) do
      true
    else
      sub = if lt.(x,y), do: a, else: b
      member?(x, sub, lt, eq) 
    end
  end

  defp balance(:black, [:red, [:red, a, x, b], y, c], z, d) do
    [:red, [:black, a, x, b], y, [:black, c, z, d]]
  end
  defp balance(:black, [:red, a, x, [:red, b, y, c]], z, d) do
    [:red, [:black, a, x, b], y, [:black, c, z, d]]
  end
  defp balance(:black, a, x, [:red, [:red, b, y, c], z, d]) do
    [:red, [:black, a, x, b], y, [:black, c, z, d]]
  end
  defp balance(:black, a, x, [:red, b, y, [:red, c, z, d]]) do
    [:red, [:black, a, x, b], y, [:black, c, z, d]]
  end
  defp balance(color, a, x, b) do
    [color, a, x, b]
  end
  defp ins(x, list) do
    ins(x, list, &(&1 < &2), &(&1 > &2))
  end
  defp ins(x, [], _, _) do
    [:red, [], x, []]
  end
  defp ins(x, tree = [color, a, y, b], lt, gt) do
    if lt.(x, y) do
     balance(color, ins(x, a), y, b)
    else
      if gt.(x, y) do
        balance(color, a, y, ins(x, b))
      else
        tree
      end
    end
  end

  @doc """
  Insert the given value into the tree specified

  ## Examples
    iex> DataStructureEx.RedBlackTree.insert(1, [])
    [:black, [], 1, []]

    iex> tree = DataStructureEx.RedBlackTree.insert(1, [])
    iex> DataStructureEx.RedBlackTree.insert(2, tree)
    [:black, [], 1, [:red, [], 2, []]]

    iex> tree = DataStructureEx.RedBlackTree.insert(1, [])
    iex> tree = DataStructureEx.RedBlackTree.insert(2, tree)
    iex> DataStructureEx.RedBlackTree.insert(3, tree)
    [:black, [:black, [], 1, []], 2, [:black, [], 3, []]]

    iex> tree = DataStructureEx.RedBlackTree.insert(3, [])
    iex> tree = DataStructureEx.RedBlackTree.insert(1, tree)
    iex> DataStructureEx.RedBlackTree.insert(2, tree)
    [:black, [:black, [], 1, []], 2, [:black, [], 3, []]]

  """
  def insert(x, tree) do
    insert(x, tree, &(&1 < &2), &(&1 > &2))
  end
  def insert(x, tree, lt, gt) do
    [_, a, y, b] = ins(x, tree, lt, gt)
    [:black, a, y, b]
  end

  @doc """
  Construct the Red Black Tree from the given list

  ## Examples
  iex> DataStructureEx.RedBlackTree.from_list([1, 2, 3, 4])
  [:black, [:black, [], 1, []], 2, [:black, [], 3, [:red, [], 4, []]]]

  """
  def from_list(list) do
    list
    |> Enum.reduce([], fn x, acc -> DataStructureEx.RedBlackTree.insert(x, acc) end)
  end
end