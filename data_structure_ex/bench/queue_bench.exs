defmodule QueueBench do
  use Benchfella

  @n 100_000
  @n2 10_000_000
  @nums 1..@n |> Enum.to_list |> Enum.shuffle
  @nums2 1..@n2 |> Enum.to_list |> Enum.shuffle
  @q1 DataStructureEx.Queue.from_list(@nums2)
  @q2 Enum.reduce(@nums2, :queue.new, fn x, queue -> :queue.snoc(queue, x) end)

  bench "list push" do
    @nums 
    |>Enum.reduce([], fn x, list -> list ++ [x] end)
  end

  bench "queue push" do
    DataStructureEx.Queue.from_list(@nums2)
  end

  bench "erlang queue push" do
    @nums2
    |> Enum.reduce(:queue.new, fn x, queue -> :queue.snoc(queue, x) end)
    # :queue.from_list(@nums2)
  end

  bench "list pop" do
    1..@n2
    |> Enum.reduce(@nums2, fn _, [_| t] -> t end)
  end

  bench "queue pop" do
    1..@n2
    |> Enum.reduce(@q1, fn _, queue -> elem(DataStructureEx.Queue.pop(queue), 1) end)
  end

  bench "erlang queue pop" do
    1..@n2
    |> Enum.reduce(@q2, fn _, queue -> 
      :queue.head(queue) 
      :queue.drop(queue) 
    end)
  end
end
