defmodule FlashcardJsonMaker.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def clear_screen(), do: Shell.cmd("clear")

  def info(text), do: Shell.info(text)

  def get_file_name(:json) do
    clear_screen()
    String.trim(Shell.prompt("Please enter the location of the JSON source file.\n(We'll be using this file to add to in our temp file):\n"))
  end

  def get_file_name(:csv) do
    clear_screen()
    String.trim(Shell.prompt("Please enter the location of the CSV source file.\n(We'll be creating new entries from this file):\n"))
  end

  def get_file_name(:temp) do
    clear_screen()
    String.trim(Shell.prompt("Please enter the location of the new JSON file to create.\n(The source json and csv will be combined in this location):\n"))
  end

  def verify_file_name(file_name, file_type) do
    Shell.cmd("clear")
    if Shell.yes?("==> #{file_name} <== selected.\n Proceed? Y/n\n"), do: "#{file_name}", else: get_file_name(file_type)
  end

  def get_verified_file_name(file_type) do
    get_file_name(file_type)
      |> verify_file_name(file_type) 
  end

end