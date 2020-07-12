defmodule CsvQuiz do
  @moduledoc """
  Documentation for CsvQuiz.
  """
  def csv_quiz(path) do
    [i, s] =
      parser(path)
      |> Enum.reduce([0, 0], fn array, [iteration, acc] -> solution(array, iteration, acc) end)

    IO.puts("\nYou scored #{s} of #{i}.")
  end

  defp parser(path) do
    File.read!(path)
    |> String.split("\n")
    |> Enum.reject(fn x -> x == "" end)
    |> Enum.map(&String.split(&1, ","))
  end

  defp solution([question, answer], iteration, acc) do
    num = iteration + 1
    input = IO.gets("Problem ##{num}: #{question} = ") |> String.trim()

    result =
      if input == answer do
        acc + 1
      else
        acc
      end

    [num, result]
  end
end
