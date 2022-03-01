defmodule FlashcardJsonMaker do
  import File
  @keys {"kanji", "fronttext", "backtext", "source", "page"}
  @moduledoc """
  Documentation for `FlashcardJsonMaker`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FlashcardJsonMaker.hello()
      :world

  """
  def hello do
    :world
  end

  def process_csv do
    read_csv_source()
      |> Stream.map(&String.trim(&1))
      |> Stream.map(&String.split(&1, ","))
      |> Stream.map(&format_csv_row_as_json_object(&1))
      |> Enum.each(&IO.puts(&1))
  end

# recurse with counter to track index position in csv
# when counter is at final index end recurse
# object construction method uses index to place value in obj
# this requires extra object passed in as well

# just got compile through, need to test format_csv_row function
  def format_csv_row_as_json_object(csv_row) do
    flashcard = empty_flashcard_json()
    format_row(csv_row, flashcard, 0)
  end

  def format_row([], flashcard, _), do: map_to_json(flashcard)

  def map_to_json(map) do
    "{\n  \"kanji\": #{map["kanji"]},\n  \"fronttext\": \"#{map["fronttext"]}\",\n  \"backtext\": \"#{map["backtext"]}\",\n  \"source\": \"#{map["source"]}\",\n  \"page\": #{map["page"]}\n}"
  end

  def format_row([current | remaining], flashcard, index) do
    updated_flashcard_map = Map.put(flashcard, elem(@keys, index), current)

    format_row(remaining, updated_flashcard_map, index + 1)
  end

  defp empty_flashcard_json, do: %{"kanji" => nil, "fronttext" => nil, "backtext" => nil, "source" => nil, "page" => nil}
  
  def read_csv_source do 
    File.stream!("./data/new_flashcards.csv") 
  end

  def parse_csv_row do
    Stream.map(&String.split(&1, ","))
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
  # Parsing
  # Function that parses one line of csv and returns appropriate json object
  # Function that read a csv file and parses each entry into a list of csv entries
  # Function that takes csv file, parses into list, then applies json conversion to each to form a new list
  #   - pipeline this

  # Reading/Writing
    # use streaming to pipeline for large csv efficiency
  # Reading one file in a hardcoded location
  # Writing to a file in a hardcoded location

  # Reading one file in a specified location
  # Writing to a file in a hardcoded location
  #   - main function takes an arugment (file_location)
end
