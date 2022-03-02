defmodule Mix.Tasks.Start do
  use Mix.Task

  def run(_), do: FlashcardJsonMaker.start_processing_files
end