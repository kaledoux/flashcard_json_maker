defmodule FlashcardJsonMaker do
  alias FlashcardJsonMaker.CLI.BaseCommands, as: CLI
  alias FlashcardJsonMaker.CsvProcessor, as: CSV
  alias FlashcardJsonMaker.JsonProcessor, as: JSON

  @moduledoc """
  Orchestrator for modules that process json source and csv source into a new temp file where all csv entries have been formatted into JSON and appended to the source list.
  """


# update documentation for how to use

@doc "transformation pipeline that does the following:
  creates new temp file from json source
  processes csv source rows into json and adds to temp
"

  def start_processing_files do
    temp_path = CLI.get_verified_file_name(:temp)
    JSON.select_and_process_json(temp_path)
    CSV.select_and_process_csv(temp_path)
    JSON.polish_temp_file(temp_path)
  end
end
