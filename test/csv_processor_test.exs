defmodule FlashcardJsonMaker.CsvProcessorTest do
  use ExUnit.Case
  import FlashcardJsonMaker.CsvProcessor

  @sample_flashcard %{"kanji" => true, "fronttext" => "front text", "backtext" => "back text", "source" => "book1", "page" => 1}
  @sample_flashcard_no_page %{"kanji" => true, "fronttext" => "front text", "backtext" => "back text", "source" => "book1", "page" => ""}
  @sample_flashcard_list ["true", "front text", "back text", "book1", 1]
  @sample_flashcard_list_no_page ["true", "front text", "back text", "book1", ""]
  @sample_flashcard_json "\n\t{\n  \t\"kanji\": true,\n  \t\"fronttext\": \"front text\",\n  \t\"backtext\": \"back text\",\n  \t\"source\": \"book1\",\n  \t\"page\": 1\n\t},"
  @sample_flashcard_json_no_page "\n\t{\n  \t\"kanji\": true,\n  \t\"fronttext\": \"front text\",\n  \t\"backtext\": \"back text\",\n  \t\"source\": \"book1\"\n\t},"

  test "keys module attribute contains proper keys" do
    assert elem(keys(), 0) == "kanji"
    assert elem(keys(), 1) == "fronttext"
    assert elem(keys(), 2) == "backtext"
    assert elem(keys(), 3) == "source"
    assert elem(keys(), 4) == "page"
  end

  test "format row returns json string when passed empty list" do
    assert format_row([], @sample_flashcard, 0) == @sample_flashcard_json
  end
  
  test "format row returns json string when passed complete list" do
    assert format_row(@sample_flashcard_list, %{}, 0) == @sample_flashcard_json
  end
  
  test "map_to_json returns properly formatted json string with page given" do
    assert map_to_json(@sample_flashcard) == @sample_flashcard_json
  end

  test "map_to_json returns properly formatted json string w/o page" do
    assert map_to_json(@sample_flashcard_no_page) == @sample_flashcard_json_no_page
  end

  test "format_row_as_json_string formats properly with page" do
    assert format_csv_row_as_json_string(@sample_flashcard_list) == @sample_flashcard_json 
  end

  test "format_row_as_json_string formats properly w/o page" do
    assert format_csv_row_as_json_string(@sample_flashcard_list_no_page) == @sample_flashcard_json_no_page 
  end
end
