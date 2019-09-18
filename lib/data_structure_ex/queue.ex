defmodule DataStructureEx.Queue do
  @moduledoc """
  The Queue based on the erlang lists.
  This module works ONLY with the list formatted by 
  DataStructureEx.Queue.insert([], value) or {[], []}
  representation.
  """

  @doc """
  Generate new queue format tupple which has two empty lists.
  To make your life easy, use this to initialize the queue.

  ## Example
    iex> DataStructureEx.Queue.new
    {[], []}
  """
  def new do
    {[], []}
  end

  @doc """
  Check whether the queue is empty or not

  ## Examples
    iex> DataStructureEx.Queue.isEmpty?({[], []})
    true

    iex> DataStructureEx.Queue.isEmpty?({[1, 2, 3], []})
    false

    iex> DataStructureEx.Queue.isEmpty?({[], [3, 2, 1]})
    false

  """
  def isEmpty?({[], []}) do
    true
  end
  def isEmpty?(_) do
    false
  end

  defp check({[], r}) do
    {Enum.reverse(r), []}
  end
  defp check(queue) do
    queue
  end

  @doc """
  Get the head value

  ## Examples
    iex> DataStructureEx.Queue.head({[1, 2, 3], [6, 5, 4]})
    1
  """
  def head({[h | _], _}) do
    h
  end

  @doc """
  Get the tail of the queue

  ## Examples
    iex> DataStructureEx.Queue.tail({[1, 2, 3], []})
    {[2, 3], []}

    iex> DataStructureEx.Queue.tail({[1], []})
    {[], []}

    iex> DataStructureEx.Queue.tail({[1, 2], []})
    {[2], []}

    iex> DataStructureEx.Queue.tail({[2], [4, 3]})
    {[3, 4], []}

  """
  def tail({[_ | t], r}) do
    check({t, r})
  end

  @doc """
  Insert the given value into the queue

  ## Examples
    iex> DataStructureEx.Queue.push([], 1)
    {[1], []}

    iex> DataStructureEx.Queue.push({[],[]}, 1)
    {[1], []}

    iex> DataStructureEx.Queue.push({[1],[]}, 2)
    {[1], [2]}

    iex> DataStructureEx.Queue.push({[],[1]}, 2)
    {[1, 2], []}

    iex> q = DataStructureEx.Queue.push({[],[]}, 1)
    iex> q = DataStructureEx.Queue.push(q, 2)
    iex> DataStructureEx.Queue.push(q, 3)
    {[1], [3, 2]}

  """
  def push([], x) do
    push({[], []}, x)
  end
  def push({f, r}, x) do
    check({f, [x]++r})
  end

  @doc """
  Pop the queue and retrieva the tuple of 
  the head value and the heap after popped.

  ## Examples
    iex> DataStructureEx.Queue.pop({[10], [3, 2, 1]})
    {10, {[1, 2, 3], []}}

    iex> DataStructureEx.Queue.pop({[1, 2], [4, 3]})
    {1, {[2], [4, 3]}}

    iex> DataStructureEx.Queue.pop({[10], []})
    {10, {[], []}}
  """
  def pop({[], []}) do
    raise "empty"
  end
  def pop({[h], r}) do
    {h, {Enum.reverse(r), []}}
  end
  def pop({[h | t], r}) do
    {h, {t, r}}
  end
  @doc """
  Convert list to queue

  ## Examples
    iex> 1..10 |> Enum.to_list |> DataStructureEx.Queue.from_list
    {[1], [10, 9, 8, 7, 6, 5, 4, 3, 2]}
  """
  def from_list(list) do
    list |> Enum.reduce({[], []}, fn x, q -> DataStructureEx.Queue.push(q, x) end) 
  end

  @doc """
  Convert queue to the list

  ## Examples
    iex> DataStructureEx.Queue.to_list({[1], [10, 9, 8, 7, 6, 5, 4, 3, 2]})
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  """
  def to_list({f, r}) do
    f++Enum.reverse(r)
  end
end