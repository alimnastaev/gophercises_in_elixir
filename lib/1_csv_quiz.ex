defmodule CsvQuiz do
  def csv_quiz(path) do
    path
    |> read_file()
    |> implemenation()
  end

  defp read_file(path), do: File.read(path)

  defp implemenation({:ok, file}) do
    [_, result] =
      file
      |> parser()
      |> Enum.reduce([0, 0], fn array, [iteration, acc] -> solution(array, iteration, acc) end)

    length =
      file
      |> parser()
      |> length()

    IO.puts("\nYou scored #{result} of #{length}.")
  end

  defp implemenation({:error, reason}), do: IO.puts("#{:file.format_error(reason)}")

  defp parser(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
  end

  defp solution([question, answer], iteration, acc) do
    num = iteration + 1
    input = IO.gets("Problem ##{num}: #{question} = ") |> String.trim()

    result = shaping_result(input, answer, acc)

    [num, result]
  end

  defp shaping_result(input, answer, acc) when input == answer, do: acc + 1
  defp shaping_result(_input, _answer, acc), do: acc
end

path = System.argv()

CsvQuiz.csv_quiz(path)
