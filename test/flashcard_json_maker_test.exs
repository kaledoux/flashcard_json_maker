defmodule FlashcardJsonMakerTest do
  use ExUnit.Case
  import FlashcardJsonMaker
  doctest FlashcardJsonMaker
  @sample_flashcard %{"kanji" => true, "fronttext" => "front text", "backtext" => "back text", "source" => "book1", "page" => 1}
  @sample_flashcard_json "{\n  \"kanji\": true,\n  \"fronttext\": \"front text\",\n  \"backtext\": \"back text\",\n  \"source\": \"book1\",\n  \"page\": 1\n}"

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
end
