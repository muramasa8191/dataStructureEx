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

defmodule DataStructureEx.BinomialHeap do
  defmodule Node do
    defstruct rank: 0, val: 0, children: []
  end
  defstruct tree: []
  defp tree(list) do
    %DataStructureEx.BinomialHeap{tree: list}
  end

  @doc """
  Link two nodes

  ## Examples
    iex> DataStructureEx.BinomialHeap.link(%DataStructureEx.BinomialHeap.Node{rank: 1, val: 1, children: []}, %DataStructureEx.BinomialHeap.Node{rank: 1, val: 2, children: []})
    %DataStructureEx.BinomialHeap.Node{rank: 2, val: 1, children: [%DataStructureEx.BinomialHeap.Node{rank: 1, val: 2, children: []}]}
  """
  def link(node1 = %Node{rank: r, val: v1, children: c1}, node2 = %Node{val: v2, children: c2}) do
    if v1 <= v2 do
      %Node{rank: r + 1, val: v1, children: [node2]++c1 }
    else
      %Node{rank: r + 1, val: v2, children: [node1]++c2 }
    end
  end

  defp rank(nil) do
    0
  end
  defp rank(%Node{rank: r}) do
    r
  end

  defp insTree(node, %DataStructureEx.BinomialHeap{tree: []}) do
    tree([node])
  end
  defp insTree(node, ts = %DataStructureEx.BinomialHeap{tree: [t | ts1]}) do
    if rank(node) < rank(t) do
      tree([node]++ts.tree)
    else
      insTree(link(node, t), tree(ts1))
    end
  end
  @doc """
  Insert Node to the list

  ## Examples
    iex> DataStructureEx.BinomialHeap.insert(1, %DataStructureEx.BinomialHeap{})
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 1}]}

    iex> heap = DataStructureEx.BinomialHeap.insert(1, %DataStructureEx.BinomialHeap{})
    iex> DataStructureEx.BinomialHeap.insert(2, heap)
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 1, val: 1, children: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 2}]}]}

    iex> heap = DataStructureEx.BinomialHeap.insert(2, %DataStructureEx.BinomialHeap{})
    iex> heap = DataStructureEx.BinomialHeap.insert(3, heap)
    iex> DataStructureEx.BinomialHeap.insert(1, heap)
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 1}, %DataStructureEx.BinomialHeap.Node{rank: 1, val: 2, children: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 3}]}]}

  """
  def insert(val, ts = %DataStructureEx.BinomialHeap{}) do
    insTree(%Node{rank: 0, val: val, children: []}, ts)
  end

  @doc """
  Merge two heaps

  ## Examples
    iex> DataStructureEx.BinomialHeap.merge(DataStructureEx.BinomialHeap.insert(1, %DataStructureEx.BinomialHeap{tree: []}), %DataStructureEx.BinomialHeap{tree: []})
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 1}]}

    iex> DataStructureEx.BinomialHeap.merge(%DataStructureEx.BinomialHeap{tree: []}, DataStructureEx.BinomialHeap.insert(1, %DataStructureEx.BinomialHeap{tree: []}))
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 1}]}

    iex> heap1 = DataStructureEx.BinomialHeap.insert(1, %DataStructureEx.BinomialHeap{tree: []})
    iex> heap2 = DataStructureEx.BinomialHeap.insert(3, %DataStructureEx.BinomialHeap{tree: []})
    iex> DataStructureEx.BinomialHeap.merge(heap1, heap2)
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 1, val: 1, children: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 3}]}]}

    iex> heap1 = DataStructureEx.BinomialHeap.insert(1, %DataStructureEx.BinomialHeap{tree: []})
    iex> heap1 = DataStructureEx.BinomialHeap.insert(2, heap1)
    iex> heap2 = DataStructureEx.BinomialHeap.insert(3, %DataStructureEx.BinomialHeap{tree: []})
    iex> DataStructureEx.BinomialHeap.merge(heap1, heap2)
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 3}, %DataStructureEx.BinomialHeap.Node{rank: 1, val: 1, children: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 2}]}]}

  """
  def merge(tree = %DataStructureEx.BinomialHeap{}, %DataStructureEx.BinomialHeap{tree: []}) do
    tree
  end
  def merge(%DataStructureEx.BinomialHeap{tree: []}, tree = %DataStructureEx.BinomialHeap{}) do
    tree
  end
  def merge(tree1 = %DataStructureEx.BinomialHeap{tree: [t1 | ts1]}, tree2 = %DataStructureEx.BinomialHeap{tree: [t2 | ts2]}) do
    cond do
      rank(t1) < rank(t2) ->
        tree([t1] ++ merge(tree(ts1), tree2).tree)
      rank(t2) < rank(t1) ->
        tree([t2] ++ merge(tree1, tree(ts2)).tree)
      true ->
        insTree(link(t1, t2), merge(tree(ts1), tree(ts2)))
    end
  end

  @doc """
  Get the tapple of node with minimum value and the tree without the node

  ## Examples
    iex> heap = %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 1}]}
    iex> DataStructureEx.BinomialHeap.removeMinTree(heap)
    {%DataStructureEx.BinomialHeap.Node{rank: 0, val: 1}, %DataStructureEx.BinomialHeap{tree: []}}

    iex> heap = %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 1, val: 1, children: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 3}]}]}
    iex> DataStructureEx.BinomialHeap.removeMinTree(heap)
    {%DataStructureEx.BinomialHeap.Node{rank: 1, val: 1, children: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 3}]}, %DataStructureEx.BinomialHeap{tree: []}}

  """
  def removeMinTree(%DataStructureEx.BinomialHeap{tree: []}) do
    raise "empty"
  end
  def removeMinTree(%DataStructureEx.BinomialHeap{tree: [t]}) do
    {t, tree([])}
  end
  def removeMinTree(%DataStructureEx.BinomialHeap{tree: [t | ts]}) do
    {node, ts2} = removeMinTree(tree(ts))
    if t.val <= node.val do 
      {t, tree(ts)}
    else 
      {node, tree([t]++ts2.tree)}
    end
  end

  @doc """
  Find minimum element

  ## Examples
    iex> heap = %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 5}]}
    iex> heap = DataStructureEx.BinomialHeap.insert(4, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(3, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(2, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(6, heap)
    iex> DataStructureEx.BinomialHeap.findMin(heap)
    %DataStructureEx.BinomialHeap.Node{
      children: [
        %DataStructureEx.BinomialHeap.Node{
          children: [
            %DataStructureEx.BinomialHeap.Node{children: [], rank: 0, val: 5}
          ],
          rank: 1,
          val: 4
        },
        %DataStructureEx.BinomialHeap.Node{children: [], rank: 0, val: 3}
      ],
      rank: 2,
      val: 2
    } 
  """
  def findMin(tree = %DataStructureEx.BinomialHeap{}) do
    elem(DataStructureEx.BinomialHeap.removeMinTree(tree), 0)
  end

  @doc """
  Delete minimum value in the Heap

  ## examples
    iex> heap = %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 5}]}
    iex> heap = DataStructureEx.BinomialHeap.insert(4, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(3, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(2, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(6, heap)
    iex> DataStructureEx.BinomialHeap.deleteMin(heap)
    %DataStructureEx.BinomialHeap{tree: [
        %DataStructureEx.BinomialHeap.Node{val: 6, rank: 0},
        %DataStructureEx.BinomialHeap.Node{
          children: [%DataStructureEx.BinomialHeap.Node{children: [], rank: 0, val: 5}],
          rank: 1,
          val: 4
        },
        %DataStructureEx.BinomialHeap.Node{children: [], rank: 0, val: 3}
        ]}

    iex> heap = %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 5}]}
    iex> heap = DataStructureEx.BinomialHeap.insert(4, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(3, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(2, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(6, heap)
    iex> heap = DataStructureEx.BinomialHeap.deleteMin(heap)
    iex> heap = DataStructureEx.BinomialHeap.deleteMin(heap)
    iex> DataStructureEx.BinomialHeap.deleteMin(heap)
    %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{
          children: [%DataStructureEx.BinomialHeap.Node{val: 6, rank: 0}], val: 5, rank: 1}]}
  """
  def deleteMin(tree = %DataStructureEx.BinomialHeap{}) do
    {%DataStructureEx.BinomialHeap.Node{children: ts1}, ts2} = DataStructureEx.BinomialHeap.removeMinTree(tree)
    DataStructureEx.BinomialHeap.merge(tree(ts1), ts2)
  end

  @doc """
  Convert Heap int list

  ## Examples
    iex> heap = %DataStructureEx.BinomialHeap{tree: [%DataStructureEx.BinomialHeap.Node{rank: 0, val: 5}]}
    iex> heap = DataStructureEx.BinomialHeap.insert(4, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(3, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(2, heap)
    iex> heap = DataStructureEx.BinomialHeap.insert(6, heap)
    iex> DataStructureEx.BinomialHeap.to_list(heap)
    [2, 3, 4, 5, 6]
  """
  def to_list(%DataStructureEx.BinomialHeap{tree: []}) do
    []
  end
  def to_list(tree = %DataStructureEx.BinomialHeap{}) do
    min_val = findMin(tree)
    ts = deleteMin(tree)
    [min_val.val]++to_list(ts)
  end
end