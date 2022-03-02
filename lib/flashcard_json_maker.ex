defmodule FlashcardJsonMaker do
  alias Mix.Shell.IO, as: Shell
  @keys {"kanji", "fronttext", "backtext", "source", "page"}

  @moduledoc """
  Documentation for `FlashcardJsonMaker`.
  """

@doc "transformation pipeline that does the following:
  reads the source file as a stream
  takes each line and parses by csv
  formats the parsed list into a json formatted string
  ... should append each item to a target json file"

  def clear_screen(), do: Shell.cmd("clear")

  def get_file_name(:json) do
    clear_screen()
    String.trim(Shell.prompt("Please enter the location of the JSON source file\n(We'll be adding new entries to this file):\n"))
  end

  def get_file_name(:csv) do
    clear_screen()
    String.trim(Shell.prompt("Please enter the location of the CSV source file\n(We'll be creating new entries from this file):\n"))
  end

  def verify_file_name(file_name, file_type) do
    Shell.cmd("clear")
    if Shell.yes?("==> #{file_name} <== selected.\n Proceed? Y/n\n"), do: "#{file_name}", else: get_file_name(file_type)
  end

  def get_verified_file_name(file_type) do
    get_file_name(file_type)
      |> verify_file_name(file_type) 
  end

  def select_and_process_csv do
    get_verified_file_name(:csv)
      |> process_csv
  end

  def process_csv(file_path) do
      read_csv_source(file_path)
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

  # def read_csv_source do 
  #   File.stream!("./data/new_flashcards.csv") 
  # end

  def read_csv_source(file_path) do 
    File.stream!(file_path) 
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

  # need to read json file and remove last bracket, add comma, then append each item in pipeline
  def keys, do: @keys

  #Whole file pipeline
  # get name of json file
  # read json file
  # get name of csv file
  # stream csv file
    # at this point we should be able to error out from erroneous file names without processing everything

  # remove trailing chars from json
  # save into variable prepped_json

  # process csv pipeline
  # each element should be added to prepped_json at the end of the pipeline

  # remove last comma and append ] to prepped_json

  # remove last ] and newline and append ,
  # String.slice(json, 0, String.length(json) - 2) <> ","
  # this will remove the trailing "]" and the newline, while also 
  # appending a ","

  # remove last comma and append closing ]
  # String.slice(json, 0, String.length(json) - 1) <> "]"
  # the new json objects all need commas except for the final item
  # the pipeline then needs to write a ] on the end of the file
  # perhaps run it through a second pipeline to remove the final comma and add the ]?
end
