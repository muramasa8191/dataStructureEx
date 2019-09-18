defmodule DataStructureEx.Tree do
  defstruct val: 0, left: nil, right: nil

  @doc """
  Check whether or not the val exists

  ## Examples

    iex> tree = %DataStructureEx.Tree{val: 10}
    iex> DataStructureEx.Tree.member?(tree, 5)
    false

    iex> tree = %DataStructureEx.Tree{val: 10, left: %DataStructureEx.Tree{val: 5}}
    iex> DataStructureEx.Tree.member?(tree, 5)
    true

    iex> tree = %DataStructureEx.Tree{val: 10, left: %DataStructureEx.Tree{val: 5, right: %DataStructureEx.Tree{val: 7}}}
    iex> DataStructureEx.Tree.member?(tree, 6)
    false

    iex> tree = %DataStructureEx.Tree{val: 10, left: %DataStructureEx.Tree{val: 5, left: %DataStructureEx.Tree{val: 4}}}
    iex> DataStructureEx.Tree.member?(tree, 4)
    true

    iex> tree = %DataStructureEx.Tree{val: 10, left: %DataStructureEx.Tree{val: 5, left: %DataStructureEx.Tree{val: 4}}}
    iex> DataStructureEx.Tree.member?(tree, 3)
    false

  """
  def member?(nil, _) do
    false
  end
  def member?(%DataStructureEx.Tree{val: v, right: r}, val) when v < val do
    member?(r, val)
  end
  def member?(%DataStructureEx.Tree{val: v, left: l}, val) when v > val do
    member?(l, val)
  end
  def member?(_, _) do
    true
  end

  @doc """
  Insert the value given into the tree specified

  ## Examples
    iex> tree = %DataStructureEx.Tree{val: 1}
    iex> DataStructureEx.Tree.insert(tree, 2)
    %DataStructureEx.Tree{right: %DataStructureEx.Tree{right: nil, left: nil, val: 2}, left: nil, val: 1}

    iex> tree = %DataStructureEx.Tree{val: 3}
    iex> tree = DataStructureEx.Tree.insert(tree, 2)
    iex> DataStructureEx.Tree.insert(tree, 1)
    %DataStructureEx.Tree{right: nil, left: %DataStructureEx.Tree{right: nil, left: %DataStructureEx.Tree{right: nil, left: nil, val: 1}, val: 2}, val: 3}

    iex> tree = %DataStructureEx.Tree{val: 2}
    iex> tree = DataStructureEx.Tree.insert(tree, 1)
    iex> DataStructureEx.Tree.insert(tree, 3)
    %DataStructureEx.Tree{right: %DataStructureEx.Tree{right: nil, left: nil, val: 3}, left: %DataStructureEx.Tree{right: nil, left: nil, val: 1}, val: 2}

  """
  def insert(nil, v) do
    %DataStructureEx.Tree{val: v}
  end
  def insert(%DataStructureEx.Tree{val: val, left: l, right: r}, v) when v > val do
    %DataStructureEx.Tree{val: val, left: l, right: insert(r, v)}
  end
  def insert(%DataStructureEx.Tree{val: val, left: l, right: r}, v) when v <= val do
    %DataStructureEx.Tree{val: val, left: insert(l, v), right: r}
  end

  @doc """
  Convert list to tree

  ## Examples
    iex> DataStructureEx.Tree.from_list([3, 1, 5, 2, 4])
    %DataStructureEx.Tree{right: %DataStructureEx.Tree{right: nil, left: %DataStructureEx.Tree{right: nil, left: nil, val: 4}, val: 5}, left: %DataStructureEx.Tree{right: %DataStructureEx.Tree{right: nil, left: nil, val: 2}, val: 1}, val: 3}
  """
  def from_list(list) do
    tree = %DataStructureEx.Tree{val: hd(list)}
    Enum.reduce(tl(list), tree, fn v, t -> DataStructureEx.Tree.insert(t, v) end)
  end

  @doc """
  

  ## Examples
    iex> tree = DataStructureEx.Tree.from_list([3, 1, 5, 2, 4])
    iex> DataStructureEx.Tree.to_list(tree)
    [1, 2, 3, 4, 5]


    iex> tree = DataStructureEx.Tree.from_list([5, 4, 3, 2, 1])
    iex> DataStructureEx.Tree.to_list(tree)
    [1, 2, 3, 4, 5]
  """
  def to_list(nil) do
    []
  end
  def to_list(%DataStructureEx.Tree{val: v, right: r, left: l}) do
    list = to_list(r)
    list = [v] ++ list
    to_list(l) ++ list
  end
  ##
  # For Enumrable. This allows Tree to apply Enum operations.
  ##
  defimpl Enumerable, for: DataStructureEx.Tree do

    def count(%DataStructureEx.Tree{right: nil, left: nil}) do
      { :ok, 1 }
    end
    def count(%DataStructureEx.Tree{right: r, left: l}) do
      len_left = if is_nil(l), do: 0, else: elem(count(l), 1)
      len_right = if is_nil(r), do: 0, else: elem(count(r), 1)
      
      { :ok, len_left + len_right + 1}
    end
    def member?(tree = %DataStructureEx.Tree{}, val) do
      { :ok, DataStructureEx.Tree.member?(tree, val) }
    end
    def reduce(tree = %DataStructureEx.Tree{}, acc, func) do
      arr = DataStructureEx.Tree.to_list(tree)
      func_wrap = fn x, {state, a} -> if state == :cont, do: func.(x, a), else: {:cont, [x]++a} end
      :lists.foldl(func_wrap, acc, arr)
    end
    def slice(tree = %DataStructureEx.Tree{}) do
      arr = DataStructureEx.Tree.to_list(tree)
      {:ok, length(arr), &Enumerable.List.slice(arr, &1, &2)}
   end
  end
end