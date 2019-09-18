defmodule DataStructureEx.SplayHeap do
  
  def new do
    []
  end

  defp partition(pivot, t) do
    partition(pivot, t, &(&1 <= &2), &({&1, &2}))
  end
  defp partition(_, [], _, fun) do
    fun.([], [])
  end
  defp partition(pivot, t = [a, x, b], lteq, fun) do
    if lteq.(x, pivot) do
      case b do
        [] -> fun.(t, [])
        [b1, y, b2] ->
          if lteq.(y, pivot) do
            partition(pivot, b2, lteq, &(fun.([[a, x, b1], y, &1], &2)))
          else
            partition(pivot, b1, lteq, &(fun.([a, x, &1], [&2, y, b2])))
          end
      end
    else
      case a do
        [] -> fun.([], t)
        [a1, y, a2] ->
          if lteq.(y, pivot) do
            partition(pivot, a2, lteq, &(fun.([a1, y, &1], [&2, x, b])))
          else
            partition(pivot, a1, lteq, &(fun.(&1, [&2, y, [a2, x, b]])))
          end
      end
    end
  end

  defp partition_org(pivot, t) do
    partition_org(pivot, t, &(&1 <= &2))
  end
  defp partition_org(_, [], _) do
    {[], []}
  end
  defp partition_org(pivot, t = [a, x, b], lteq) do
    if lteq.(x, pivot) do
      case b do
        [] -> {t, []}
        [b1, y, b2] ->
          if lteq.(y, pivot) do
            {small, big} = partition_org(pivot, b2, lteq)
            {[[a, x, b1], y, small], big}
          else
            {small, big} = partition_org(pivot, b1, lteq)
            {[a, x, small], [big, y, b2]}
          end
      end
    else
      case a do
        [] -> {[], t}
        [a1, y, a2] ->
          if lteq.(y, pivot) do
            {small, big} = partition_org(pivot, a2, lteq)
            {[a1, y, small], [big, x, b]}
          else
            {small, big} = partition_org(pivot, a1, lteq)
            {small, [big, y, [a2, x, b]]}
          end
      end
    end
  end

  @doc """
  Find the minimum value in the heap

  ## Examples
    iex> DataStructureEx.SplayHeap.findMin([1, [], [], []])
    1

    iex> DataStructureEx.SplayHeap.findMin([2, [], 5, [[], 6, []]])
    2

  """
  def findMin([m, [], _, _]) do
    m
  end

  @doc """
  Delete the minimum value in the heap

  ## Examples
    iex> DataStructureEx.SplayHeap.deleteMin([10, [], 15, []])
    [15, [], [], []]

    iex> DataStructureEx.SplayHeap.deleteMin([5, [[], 7, []], 10, []])
    [7, [], 10, []]

    iex> DataStructureEx.SplayHeap.deleteMin([1, [], 2, [[], 3, [[], 5, [[], 10, [[], 15, []]]]]])
    [2, [], 3, [[], 5, [[], 10, [[], 15, []]]]]

  """
  def deleteMin([_, [], x, []]) do
    [x, [], [], []]
  end
  def deleteMin([_, [], x, b]) do
    [x] ++ b
  end
  def deleteMin([_, [[], x, b], y, c]) do
    [x, b, y, c]
  end
  def deleteMin(_, [[a, x, b], y, c]) do
    [m, d, z, e] = deleteMin([[]]++a)
    [m, [d, z, e], x, [b, y, c]]
  end

  @doc """
  Insert the given value into the heap specified

  ## Examples
    iex> DataStructureEx.SplayHeap.insert(1, [])
    [1, [], [], []]

    iex> heap = DataStructureEx.SplayHeap.insert(3, [])
    iex> heap = DataStructureEx.SplayHeap.insert(2, heap)
    iex> DataStructureEx.SplayHeap.insert(1, heap)
    [1, [], 2, [[], 3, []]]
  """
  def insert(x, nums) do
    insert(x, nums, &(&1 < &2))
  end
  def insert(x, [], _) do
    [x, [], [], []]
  end
  def insert(x, [m, [], [], []], comp) do
    if comp.(x, m) do
      [x, [], m, []]
    else
      [m, [], x, []]
    end
  end
  def insert(x, [m, a, y, b], comp) do
    
    if comp.(x, m) do
      {c, d} = partition(m, [a, y, b])
      [x, c, m, d]
    else
      {c, d} = partition(x, [a, y, b])
      [m, c, x, d]
    end
  end

  def insert_org(x, nums) do
    insert(x, nums, &(&1 < &2))
  end
  def insert_org(x, [], _) do
    [x, [], [], []]
  end
  def insert_org(x, [m, [], [], []], comp) do
    if comp.(x, m) do
      [x, [], m, []]
    else
      [m, [], x, []]
    end
  end
  def insert_org(x, [m, a, y, b], comp) do
    
    if comp.(x, m) do
      {c, d} = partition_org(m, [a, y, b])
      [x, c, m, d]
    else
      {c, d} = partition_org(x, [a, y, b])
      [m, c, x, d]
    end
  end
  @doc """
  Convert thie give list into the list depicting SplayHeap representation

  ## Examples
    iex> DataStructureEx.SplayHeap.from_list(1..5 |> Enum.to_list)
    [1, [[[[], 2, []], 3, []], 4, []] , 5 , []]
  """
  def from_list(list) do
    list
    |> List.foldl([], fn x, heap -> DataStructureEx.SplayHeap.insert(x, heap) end)
  end

  def from_list_org(list) do
    list
    |> Enum.reduce([], fn x, heap -> DataStructureEx.SplayHeap.insert_org(x, heap) end)
  end
end