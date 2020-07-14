defmodule CsvQuiz do
  @moduledoc """
  Documentation for CsvQuiz.
  """

  def csv_quiz(path) do
    # case statement to handle error if something wrong
    # with csv file or the path
    case File.read(path) do
      {:error, reason} ->
        IO.puts("#{:file.format_error(reason)}")

      {:ok, file} ->
        [_, result] =
          parser(file)
          |> Enum.reduce([0, 0], fn array, [iteration, acc] -> solution(array, iteration, acc) end)

        IO.puts("\nYou scored #{result} of #{length(parser(file))}.")
    end
  end

  # function to parse a csv file and shape it to
  # to iterate: [[problem, answer]]
  defp parser(file) do
    file
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

path = System.argv()

CsvQuiz.csv_quiz(path)
