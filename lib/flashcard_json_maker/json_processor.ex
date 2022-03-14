defmodule FlashcardJsonMaker.JsonProcessor do
  alias FlashcardJsonMaker.CLI.BaseCommands, as: CLI
  import Jason.Formatter

  def select_and_process_json(temp_file_name) do
    CLI.get_verified_file_name(:json) 
      |> prep_json
      |> write_to_temp_file(temp_file_name)
  end

  def polish_temp_file(temp_path) do
    File.read!(temp_path)
      |> remove_comma_and_add_bracket
      |> pretty_print
      |> write_to_temp_file(temp_path)
  end

  def prep_json(file_name) do
    File.read!(file_name)
      |> remove_bracket_and_add_comma
  end

  def remove_bracket_and_add_comma(json) do
    String.slice(json, 0, String.length(json) - 2) <> ","
  end

  def remove_comma_and_add_bracket(json) do
    String.slice(json, 0, String.length(json) - 1) <> "\n]"
  end

  def write_to_temp_file(content, temp_path) do
    File.write(temp_path, content)
  end
end