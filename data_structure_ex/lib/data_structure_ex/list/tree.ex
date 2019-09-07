defmodule DataStructureEx.List.Tree do

  @doc """
  Check whether or not the val exists

  ## Examples

    iex> tree = [nil, 10, nil]
    iex> DataStructureEx.List.Tree.member?(tree, 5)
    false

    iex> tree = [[nil, 5, nil], 10, nil]
    iex> DataStructureEx.List.Tree.member?(tree, 5)
    true

    iex> tree = [[nil, 5, nil], 7, [nil, 10, nil]]
    iex> DataStructureEx.List.Tree.member?(tree, 6)
    false

    iex> tree = [[[nil, 4, nil], 5, nil], 10, nil]
    iex> DataStructureEx.List.Tree.member?(tree, 4)
    true

    iex> tree = [[[nil, 4, nil], 5, nil], 10, nil]
    iex> DataStructureEx.List.Tree.member?(tree, 3)
    false

  """
  def member?(nil, _) do
    false
  end
  def member?([_, v, r], val) when v < val do
    member?(r, val)
  end
  def member?([l, v, _], val) when v > val do
    member?(l, val)
  end
  def member?(_, _) do
    true
  end

  @doc """
  Insert the value given into the tree specified

  ## Examples
    iex> tree = DataStructureEx.List.Tree.insert(nil, 1)
    iex> DataStructureEx.List.Tree.insert(tree, 2)
    [nil, 1, [nil, 2, nil]]

    iex> tree = DataStructureEx.List.Tree.insert(nil, 3)
    iex> tree = DataStructureEx.List.Tree.insert(tree, 2)
    iex> DataStructureEx.List.Tree.insert(tree, 1)
    [[[nil, 1, nil], 2, nil], 3, nil]

    iex> tree = tree = DataStructureEx.List.Tree.insert(nil, 2)
    iex> tree = DataStructureEx.List.Tree.insert(tree, 1)
    iex> DataStructureEx.List.Tree.insert(tree, 3)
    [[nil, 1, nil], 2, [nil, 3, nil]]

  """
  def insert(nil, v) do
    [nil, v, nil]
  end
  def insert([left, val, right], v) when v > val do
    [left, val, insert(right, v)]
  end
  def insert([left, val, right], v) when v <= val do
    [insert(left, v), val, right]
  end

  @doc """
  Convert list to tree

  ## Examples
    iex> DataStructureEx.List.Tree.from_list([3, 1, 5, 2, 4])
    [[nil, 1, [nil, 2, nil]], 3, [[nil, 4, nil], 5, nil]]
  """
  def from_list(list) do
    Enum.reduce(list, nil, fn v, t -> DataStructureEx.List.Tree.insert(t, v) end)
  end

  @doc """
  

  ## Examples
    iex> tree = DataStructureEx.List.Tree.from_list([3, 1, 5, 2, 4])
    iex> DataStructureEx.List.Tree.to_list(tree)
    [1, 2, 3, 4, 5]


    iex> tree = DataStructureEx.List.Tree.from_list([5, 4, 3, 2, 1])
    iex> DataStructureEx.List.Tree.to_list(tree)
    [1, 2, 3, 4, 5]
  """
  def to_list(nil) do
    []
  end
  def to_list([left, val, right]) do
    list = to_list(right)
    list = [val] ++ list
    to_list(left) ++ list
  end
end