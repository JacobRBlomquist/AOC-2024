defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  @doc """
  This time, you'll need to figure out exactly how often each number from the left list appears in the right list.
  Calculate a total similarity score by adding up each number in the left list after multiplying it by the
  number of times that number appears in the right list.

  Here are the same example lists again:

  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  For these example lists, here is the process of finding the similarity score:

  The first number in the left list is 3. It appears in the right list three times, so the similarity score increases by 3 * 3 = 9.
  The second number in the left list is 4. It appears in the right list once, so the similarity score increases by 4 * 1 = 4.
  The third number in the left list is 2. It does not appear in the right list, so the similarity score does not increase (2 * 0 = 0).
  The fourth number, 1, also does not appear in the right list.
  The fifth number, 3, appears in the right list three times; the similarity score increases by 9.
  The last number, 3, appears in the right list three times; the similarity score again increases by 9.
  So, for these example lists, the similarity score at the end of this process is 31 (9 + 4 + 0 + 0 + 9 + 9).

  Once again consider your left and right lists. What is their similarity score?
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
    calc = do_calc(first_sorted, second_sorted)
    IO.puts("Calc: #{calc}")
  end

  def do_calc(first, second) do
    mults =
      Enum.map(
        first,
        fn left ->
          num_in_right = Enum.reduce(
            second,
            0,
            fn right, acc ->
              if left == right do
                acc + 1
              else
                acc
              end
            end
          )
          left * num_in_right
        end
      )
    IO.inspect(mults)
    Enum.sum(mults)
  end

  def read_file(path) do
    {:ok, contents} = File.read(path)
    {:ok, contents}
  end
end
