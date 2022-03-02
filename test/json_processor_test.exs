defmodule FlashcardJsonMaker.JsonProcessorTest do
  use ExUnit.Case
  import FlashcardJsonMaker.JsonProcessor

  @source_polished "[\n  {\n    \"kanji\": true,\n    \"fronttext\": \"今日\",\n    \"backtext\": \"Today\",\n    \"source\": \"book1\"\n  },\n  {\n    \"kanji\": false,\n    \"fronttext\": \"した\",\n    \"backtext\": \"under\",\n    \"source\": \"book1\"\n  },\n  {\n    \"kanji\": false,\n    \"fronttext\": \"どこか\",\n    \"backtext\": \"somewhere, anywhere\",\n    \"source\": \"book2\",\n    \"page\": 3\n  }\n]"

  @source_prepped "[\n  {\n    \"kanji\": true,\n    \"fronttext\": \"今日\",\n    \"backtext\": \"Today\",\n    \"source\": \"book1\"\n  },\n  {\n    \"kanji\": false,\n    \"fronttext\": \"した\",\n    \"backtext\": \"under\",\n    \"source\": \"book1\"\n  },\n  {\n    \"kanji\": false,\n    \"fronttext\": \"どこか\",\n    \"backtext\": \"somewhere, anywhere\",\n    \"source\": \"book2\",\n    \"page\": 3\n  },"

  test "prep json reads source file and removes ] and adds comma" do
    assert prep_json("./test/data/flashcards.json") == @source_prepped
  end

  test "remove bracket and add comma does as the name states" do
    assert remove_bracket_and_add_comma(@source_polished) == @source_prepped
  end

  test "remove command and add bracket does as the name states" do
    assert remove_comma_and_add_bracket(@source_prepped) == @source_polished
  end
end