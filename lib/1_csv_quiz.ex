defmodule CsvQuiz do
  def csv_quiz(path) do
    path |> File.read() |> build_score()
  end

  defp build_score({:error, reason}), do: IO.puts("#{:file.format_error(reason)}")

  defp build_score({:ok, file}) do
    file
    |> parse()
    |> Enum.reduce({0, 0}, fn [question, expected_answer], {score, counter} ->
      counter = counter + 1

      score =
        question
        |> ask(counter)
        |> then(fn
          answer when answer == expected_answer -> score + 1
          _ -> score
        end)

      {score, counter}
    end)
    |> then(fn {score, counter} ->
      IO.puts("\nYou scored #{score} of #{counter}.")
    end)
  end

  defp ask(question, counter) do
    "Problem ##{counter}: #{question} = " |> IO.gets() |> String.trim()
  end

  defp parse(file) do
    file |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, ","))
  end
end

CsvQuiz.csv_quiz(System.argv())
