defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @doc """
  For example:

  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  Maybe the lists are only off by a small amount! To find out, pair up the numbers and measure how far apart they are. Pair up the smallest number in the left list with the smallest number in the right list, then the second-smallest left number with the second-smallest right number, and so on.

  Within each pair, figure out how far apart the two numbers are; you'll need to add up all of those distances. For example, if you pair up a 3 from the left list with a 7 from the right list, the distance apart is 4; if you pair up a 9 with a 3, the distance apart is 6.

  In the example list above, the pairs and distances would be as follows:

  The smallest number in the left list is 1, and the smallest number in the right list is 3. The distance between them is 2.
  The second-smallest number in the left list is 2, and the second-smallest number in the right list is another 3. The distance between them is 1.
  The third-smallest number in both lists is 3, so the distance between them is 0.
  The next numbers to pair up are 3 and 4, a distance of 1.
  The fifth-smallest numbers in each list are 3 and 5, a distance of 2.
  Finally, the largest number in the left list is 4, while the largest number in the right list is 9; these are a distance 5 apart.
  To find the total distance between the left list and the right list, add up the distances between all of the pairs you found. In the example above, this is 2 + 1 + 0 + 1 + 2 + 5, a total distance of 11!

  Your actual left and right lists contain many location IDs. What is the total distance between your lists?
  """
  def main do
    {:ok, contents} = read_file("input.txt")
    # IO.puts(contents)
    lines = String.split(contents, "\r\n")
    groups = Enum.map(lines, fn x -> String.split(x, "   ") end)

    {first_list, second_list} =
      Enum.reduce(groups, {[], []}, fn [first, second], {acc1, acc2} ->
        {[String.to_integer(first) | acc1], [String.to_integer(second) | acc2]}
      end)

    first_sorted = Enum.sort(first_list)
    second_sorted = Enum.sort(second_list)
    IO.inspect(first_sorted)
    sum = do_sum(first_sorted, second_sorted)
    IO.puts("SUM: #{sum}")
  end



  def do_sum([num1 | rest1], [num2 | rest2]) do
    IO.puts("Comparing #{num1} #{num2} -> #{abs(num1 - num2)}")
    sum = abs(num1 - num2)
    sum = sum + do_sum(rest1, rest2)
    sum
  end

  def do_sum(_, _) do
    0
  end

  def read_file(path) do
    {:ok, contents} = File.read(path)
    {:ok, contents}
  end
end
