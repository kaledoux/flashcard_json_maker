defmodule FlashcardJsonMaker.CsvProcessor do
  alias FlashcardJsonMaker.CLI.BaseCommands, as: CLI
  @keys {"kanji", "fronttext", "backtext", "source", "page"}

  def select_and_process_csv(temp_path) do
    CLI.get_verified_file_name(:csv)
      |> process_csv(temp_path)
  end

  def process_csv(csv_path, temp_path) do
    {:ok, temp_json_file} = File.open(temp_path, [:append, :utf8])

    File.stream!(csv_path)
      |> Stream.map(&String.trim(&1))
      |> Stream.map(&String.split(&1, ","))
      |> Stream.map(&format_csv_row_as_json_string(&1))
      |> Enum.each(&IO.write(temp_json_file, &1))

  end

@doc """
Recurse for each list item of split csv row, adding as value to map based on the associated indexed key in keys
"""

  def format_csv_row_as_json_string(csv_row) do
    format_row(csv_row, %{}, 0)
  end

  def format_row([], flashcard, _), do: map_to_json(flashcard)

  def format_row([current | remaining], flashcard, index) do
    updated_flashcard_map = Map.put(flashcard, elem(@keys, index), current)

    format_row(remaining, updated_flashcard_map, index + 1)
  end

@doc """
Format json strings in matching order to source
"""
  def map_to_json(%{"page" => page_value} = map) when page_value == "", do: "\n\t\t{\n  \t\t\"kanji\": #{map["kanji"]},\n  \t\t\"fronttext\": \"#{map["fronttext"]}\",\n  \t\t\"backtext\": \"#{map["backtext"]}\",\n  \t\t\"source\": \"#{map["source"]}\"\n\t\t},"

  def map_to_json(map), do: "\n\t\t{\n  \t\t\"kanji\": #{map["kanji"]},\n  \t\t\"fronttext\": \"#{map["fronttext"]}\",\n  \t\t\"backtext\": \"#{map["backtext"]}\",\n  \t\t\"source\": \"#{map["source"]}\",\n  \t\t\"page\": #{map["page"]}\n\t\t},"

  def keys, do: @keys
end