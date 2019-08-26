defmodule DataStructureEx.Stack do
  defstruct data: []
  @doc """
  Check whether or not the data is empty

  ## Examples

    iex> stack = %DataStructureEx.Stack{data: []}
    iex> DataStructureEx.Stack.isEmpty(stack)
    true

    iex> stack = %DataStructureEx.Stack{data: [1]}
    iex> DataStructureEx.Stack.isEmpty(stack)
    false
  """
  def isEmpty(%DataStructureEx.Stack{data: d}) when d == [] do
    true
  end
  def isEmpty(_) do
    false
  end

  @doc """
  Add the value into the stack

  ## Examples

    iex> stack = %DataStructureEx.Stack{data: []}
    iex> DataStructureEx.Stack.cons(stack, 1)
    %DataStructureEx.Stack{data: [1]}

    iex> stack = %DataStructureEx.Stack{data: []}
    iex> stack = DataStructureEx.Stack.cons(stack, 1)
    iex> DataStructureEx.Stack.cons(stack, 2)
    %DataStructureEx.Stack{data: [2, 1]}
  """
  def cons(stack = %DataStructureEx.Stack{}, x) do
    %DataStructureEx.Stack{data: [x] ++ stack.data}
  end

  @doc """
  Obtain the values of the top of the data

  ## Examples

    iex> stack = %DataStructureEx.Stack{data: [3, 2, 1]}
    iex> DataStructureEx.Stack.head(stack)
    %DataStructureEx.Stack{data: [3]}

  """
  def head(stack = %DataStructureEx.Stack{}) do
    %DataStructureEx.Stack{data: [hd(stack.data)]}
  end

  @doc """
  Obtain the values in the data without head

  ## Examples

    iex> stack = %DataStructureEx.Stack{data: [3, 2, 1]}
    iex> DataStructureEx.Stack.tail(stack)
    %DataStructureEx.Stack{data: [2, 1]}

  """
  def tail(stack = %DataStructureEx.Stack{}) do
    %DataStructureEx.Stack{data: tl(stack.data)}
  end

  ##
  # For Enumrable. This allows Stack to apply Enum operations.
  ##
  defimpl Enumerable, for: DataStructureEx.Stack do

    def count(%DataStructureEx.Stack{data: arr}) do
      { :ok, length(arr)}
    end
    def member?(%DataStructureEx.Stack{data: arr}, val) do
      { :ok, Enum.any?(arr, fn x -> x == val end) }
    end
    def reduce(%DataStructureEx.Stack{data: arr}, acc, func) do
      func_wrap = fn x, {state, a} -> if state == :cont, do: func.(x, a), else: {:cont, [x]++a} end
      :lists.foldl(func_wrap, acc, arr)
    end
    def slice(%DataStructureEx.Stack{data: arr}) do
      {:ok, length(arr), &Enumerable.List.slice(arr, &1, &2)}
    end
  end
end