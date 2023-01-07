defmodule CsvQuiz do
  def csv_quiz(path) do
    path |> read_file() |> implementation()
  end

  defp read_file(path), do: File.read(path)

  defp implementation({:ok, file}) do
    [_, result] =
      file
      |> parser()
      |> Enum.reduce([0, 0], fn array, [iteration, acc] -> solution(array, iteration, acc) end)

    length = file |> parser() |> length()

    IO.puts("\nYou scored #{result} of #{length}.")
  end

  defp implementation({:error, reason}), do: IO.puts("#{:file.format_error(reason)}")

  defp parser(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
  end

  defp solution([question, answer], iteration, acc) do
    num = iteration + 1

    input = "Problem ##{num}: #{question} = " |> IO.gets() |> String.trim()

    result = build_result(input, answer, acc)

    [num, result]
  end

  defp build_result(input, input, acc), do: acc + 1
  defp build_result(_, _, acc), do: acc
end

path = System.argv()

CsvQuiz.csv_quiz(path)
