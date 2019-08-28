defmodule DataStructureEx.LeftistHeap do
  defstruct rank: 0, val: 0, left: nil, right: nil

  @doc """
  Retrieve the rank of the heap

  ## Examples
    iex> heap = %DataStructureEx.LeftistHeap{rank: 0, val: 1}
    iex> DataStructureEx.LeftistHeap.rank(heap)
    0

    iex> heap = %DataStructureEx.LeftistHeap{rank: 1, val: 1, left: %DataStructureEx.LeftistHeap{rank: 0, val: 2}}
    iex> DataStructureEx.LeftistHeap.rank(heap)
    1
  """
  def rank(nil) do
    0
  end
  def rank(%DataStructureEx.LeftistHeap{rank: r}) do
    r
  end

  @doc """
  Make a new heap from the value and two heaps

  ## Examples
    iex> heap1 = %DataStructureEx.LeftistHeap{rank: 1, val: 1, left: %DataStructureEx.LeftistHeap{rank: 0, val: 2}}
    iex> heap2 = %DataStructureEx.LeftistHeap{rank: 0, val: 2}
    iex> DataStructureEx.LeftistHeap.makeHeap(3, heap1, heap2)
    %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 1, left: %DataStructureEx.LeftistHeap{rank: 0, val: 2, left: nil, right: nil}}, right: %DataStructureEx.LeftistHeap{rank: 0, val: 2, left: nil, right: nil}}
  """
  def makeHeap(x, a, b) do
    rank_a = DataStructureEx.LeftistHeap.rank(a)
    rank_b = DataStructureEx.LeftistHeap.rank(b)
    if rank_a >= rank_b do
      %DataStructureEx.LeftistHeap{rank: rank_b + 1, val: x, left: a, right: b}
    else
      %DataStructureEx.LeftistHeap{rank: rank_a + 1, val: x, left: b, right: a}
    end
  end

  @doc """
  Merge the two heaps

  ## Examples
    iex> heap1 = %DataStructureEx.LeftistHeap{rank: 1, val: 1}
    iex> heap2 = %DataStructureEx.LeftistHeap{rank: 1, val: 2}
    iex> DataStructureEx.LeftistHeap.merge(heap1, heap2)
    %DataStructureEx.LeftistHeap{rank: 1, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 2}, right: nil}

    iex> heap1 = %DataStructureEx.LeftistHeap{rank: 1, val: 2}
    iex> heap2 = %DataStructureEx.LeftistHeap{rank: 1, val: 1}
    iex> DataStructureEx.LeftistHeap.merge(heap1, heap2)
    %DataStructureEx.LeftistHeap{rank: 1, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 2}, right: nil}

    iex> heap1 = %DataStructureEx.LeftistHeap{rank: 1, val: 2}
    iex> heap2 = %DataStructureEx.LeftistHeap{rank: 1, val: 1}
    iex> heap3 = %DataStructureEx.LeftistHeap{rank: 1, val: 3}
    iex> heap = DataStructureEx.LeftistHeap.merge(heap1, heap2)
    iex> DataStructureEx.LeftistHeap.merge(heap, heap3)
    %DataStructureEx.LeftistHeap{rank: 2, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 2}, right: %DataStructureEx.LeftistHeap{rank: 1, val: 3}}

    iex> heap1 = %DataStructureEx.LeftistHeap{rank: 1, val: 4}
    iex> heap2 = %DataStructureEx.LeftistHeap{rank: 1, val: 3}
    iex> heap3 = %DataStructureEx.LeftistHeap{rank: 1, val: 2}
    iex> heap4 = %DataStructureEx.LeftistHeap{rank: 1, val: 1}
    iex> heap_m1 = DataStructureEx.LeftistHeap.merge(heap1, heap2)
    iex> heap_m2 = DataStructureEx.LeftistHeap.merge(heap_m1, heap3)
    iex> DataStructureEx.LeftistHeap.merge(heap_m2, heap4)
    %DataStructureEx.LeftistHeap{rank: 1, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 2, left: %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 4}}}}

  """
  def merge(heap, nil) do
    heap
  end
  def merge(nil, heap) do
    heap
  end
  def merge(heap1 = %DataStructureEx.LeftistHeap{val: v1, left: l1, right: r1}, heap2 = %DataStructureEx.LeftistHeap{val: v2, left: l2, right: r2}) do
    if v1 <= v2 do
      DataStructureEx.LeftistHeap.makeHeap(v1, l1, DataStructureEx.LeftistHeap.merge(r1, heap2))
    else
      DataStructureEx.LeftistHeap.makeHeap(v2, l2, DataStructureEx.LeftistHeap.merge(heap1, r2))
    end
  end

  @doc """
  Insert the value val into the heap

  ## Examples
    iex> DataStructureEx.LeftistHeap.insert(1, nil)
    %DataStructureEx.LeftistHeap{rank: 1, val: 1}

    iex> DataStructureEx.LeftistHeap.insert(2, %DataStructureEx.LeftistHeap{rank: 1, val: 1})
    %DataStructureEx.LeftistHeap{rank: 1, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 2}}

    iex> heap = DataStructureEx.LeftistHeap.insert(2, %DataStructureEx.LeftistHeap{rank: 1, val: 1})
    iex> DataStructureEx.LeftistHeap.insert(3, heap)
    %DataStructureEx.LeftistHeap{rank: 2, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 2}, right: %DataStructureEx.LeftistHeap{rank: 1, val: 3}}

    iex> heap = DataStructureEx.LeftistHeap.insert(3, %DataStructureEx.LeftistHeap{rank: 1, val: 4})
    iex> heap = DataStructureEx.LeftistHeap.insert(1, heap)
    iex> DataStructureEx.LeftistHeap.insert(2, heap)
    %DataStructureEx.LeftistHeap{rank: 2, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 4}}, right: %DataStructureEx.LeftistHeap{rank: 1, val: 2}}

  """
  def insert(val, heap) do
    DataStructureEx.LeftistHeap.merge(%DataStructureEx.LeftistHeap{rank: 1, val: val}, heap)
  end

  @doc """
  Get the minimum value in the heap

  ## Examples
    iex> heap = %DataStructureEx.LeftistHeap{rank: 2, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 4}}, right: %DataStructureEx.LeftistHeap{rank: 1, val: 2}}
    iex> DataStructureEx.LeftistHeap.findMin(heap)
    1
  """
  def findMin(%DataStructureEx.LeftistHeap{val: val}) do
    val
  end

  @doc """
  Delete the minimum value
    
  ## Examples
    iex> heap = %DataStructureEx.LeftistHeap{rank: 2, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 4}}, right: %DataStructureEx.LeftistHeap{rank: 1, val: 2}}
    iex> DataStructureEx.LeftistHeap.deleteMin(heap)
    %DataStructureEx.LeftistHeap{rank: 1, val: 2, left: %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 4}}, right: nil}

    iex> heap = %DataStructureEx.LeftistHeap{rank: 1, val: 1}
    iex> DataStructureEx.LeftistHeap.deleteMin(heap)
    nil
  """
  def deleteMin(%DataStructureEx.LeftistHeap{left: l, right: r}) do
    DataStructureEx.LeftistHeap.merge(l, r)
  end

  @doc """
  Convert the heap to list

  ## Examples
    iex> heap = %DataStructureEx.LeftistHeap{rank: 2, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 4}}, right: %DataStructureEx.LeftistHeap{rank: 1, val: 2}}
    iex> DataStructureEx.LeftistHeap.to_list(heap)
    [1, 2, 3, 4]

    iex> heap = %DataStructureEx.LeftistHeap{rank: 2, val: 1, left: %DataStructureEx.LeftistHeap{rank: 1, val: 3, left: %DataStructureEx.LeftistHeap{rank: 1, val: 4}}, right: %DataStructureEx.LeftistHeap{rank: 1, val: 2}}
    iex> heap = DataStructureEx.LeftistHeap.deleteMin(heap)
    iex> DataStructureEx.LeftistHeap.to_list(heap)
    [2, 3, 4]

  """
  def to_list(nil) do
    []
  end
  def to_list(heap = %DataStructureEx.LeftistHeap{}) do
    val = DataStructureEx.LeftistHeap.findMin(heap)
    [val] ++ DataStructureEx.LeftistHeap.to_list(DataStructureEx.LeftistHeap.deleteMin(heap))
  end

end