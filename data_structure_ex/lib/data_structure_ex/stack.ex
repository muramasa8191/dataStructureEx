defmodule DataStructureEx.Stack do
  @doc """
  Check whether or not the data is empty

  ## Examples
    iex> DataStructureEx.Stack.isEmpty([])
    true

    iex> DataStructureEx.Stack.isEmpty([1])
    false
  """
  def isEmpty(stack) when stack == [] do
    true
  end
  def isEmpty(_) do
    false
  end

  @doc """
  Add the value into the stack

  ## Examples

    iex> stack = []
    iex> DataStructureEx.Stack.cons(stack, 1)
    [1]

    iex> stack = []
    iex> stack = DataStructureEx.Stack.cons(stack, 1)
    iex> DataStructureEx.Stack.cons(stack, 2)
    [2, 1]
  """
  def cons(stack, x) do
    [x] ++ stack
  end

  @doc """
  Obtain the values of the top of the data

  ## Examples
    iex> stack = [3, 2, 1]
    iex> DataStructureEx.Stack.head(stack)
    3

  """
  def head(stack) do
    hd stack
  end

  @doc """
  Obtain the values in the data without head

  ## Examples

    iex> stack = [3, 2, 1]
    iex> DataStructureEx.Stack.tail(stack)
    [2, 1]

  """
  def tail(stack) do
    tl stack
  end
end