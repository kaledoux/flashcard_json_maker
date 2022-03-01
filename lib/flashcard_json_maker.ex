defmodule FlashcardJsonMaker do
  @keys {"kanji", "fronttext", "backtext", "source", "page"}
  @moduledoc """
  Documentation for `FlashcardJsonMaker`.
  """

@doc "transformation pipeline that does the following:
  reads the source file as a stream
  takes each line and parses by csv
  formats the parsed list into a json formatted string
  ... should append each item to a target json file"

  def process_csv do
    read_csv_source()
      |> Stream.map(&String.trim(&1))
      |> Stream.map(&String.split(&1, ","))
      |> Stream.map(&format_csv_row_as_json_string(&1))
      |> Enum.each(&IO.puts(&1))
  end

  def format_csv_row_as_json_string(csv_row) do
    format_row(csv_row, %{}, 0)
  end

  def format_row([], flashcard, _), do: map_to_json(flashcard)

  def format_row([current | remaining], flashcard, index) do
    updated_flashcard_map = Map.put(flashcard, elem(@keys, index), current)

    format_row(remaining, updated_flashcard_map, index + 1)
  end

  def map_to_json(map) do
    "{\n  \"kanji\": #{map["kanji"]},\n  \"fronttext\": \"#{map["fronttext"]}\",\n  \"backtext\": \"#{map["backtext"]}\",\n  \"source\": \"#{map["source"]}\",\n  \"page\": #{map["page"]}\n}"
  end

  def read_csv_source do 
    File.stream!("./data/new_flashcards.csv") 
  end

  # General Requirements:
  # Take a csv file
  #   delimited by "," for fields and "\n" for entries
  # Parse csv file entries and create json objects
  # Read import file
  #   Hardcode file location to read/write initially
  #   Specify file location eventually
  # Append json objects to the end of import file
  #   Write to file, appending, not replacing

  # RoadMap:
  # Writing to a file in a hardcoded location

  # Reading one file in a specified location
  # Writing to a file in a hardcoded location
  #   - main function takes an arugment (file_location)
  def keys, do: @keys
end
