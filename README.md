# FlashcardJsonMaker
## Summary
A simple application for quickly adding more flashcard data to an exiting JSON data file; this was built with the [flashcard app](https://github.com/EdgeCaseBerg/bsyjpncards.org) by EdgeCaseBerg in mind, specifically.

This app will read a source JSON file and a source CSV file with flashcard additions, and create a new temp file with the CSV rows converted to JSON and appended to the original. 

You can verify additions in the temp and then replace the source JSON file.

## Installation
No install is necessary beyond cloning the repo and making sure you have Erlang runtime and Elixir ~> 1.13 in your runtime environment.

## Running the Program
Simply run `mix start` and the program will start.

## How it works
The program works on the basis of a source JSON file, a source CSV file, and newly created "temp" file. You will need to specify a file directory for all three within your CLI.

The program will ask you to provide a new file location for the "temp" file, then the source JSON file location, followed by the source CSV location. 

Remember **the locations you provide are relative to the directory in which you are running the program** so take care to reference properly. 

### CSV Formatting
The program assumes that data in the CSV will be formatted in the following pattern:
```
kanji,fronttext,backtext,source,page(optional)
```
So an example might look like so:
```
true,明日,tomorrow,book1,
true,上,over,book1,
false,どこも,nowhere or everywhere,book2,3
```

Note that the `page` attribute does not need to be present, but the comma that delineates the `source` and `page` *is required*.

Bear in mind that each row must be separated by a newline (`\n`).

## Invalid File Location
The program will crash out if you specify a JSON or CSV source location that does not exist. 

## Temp file Overwrite
**Be careful naming your temp file as it will overwrite any file of the same name**

