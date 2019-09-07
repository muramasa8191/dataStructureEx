defmodule SplayHeapBench do
  use Benchfella

  @nums 1..1_000_000 |> Enum.to_list |> Enum.shuffle

  bench "normal" do
    DataStructureEx.SplayHeap.from_list_org(@nums)
  end

  bench "tail call" do
    DataStructureEx.SplayHeap.from_list(@nums)
  end

end