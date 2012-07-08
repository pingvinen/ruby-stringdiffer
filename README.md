ruby-stringdiffer
=================

A very basic string diffing library for comparison of sentences.

The primary purpose of the library, was to help me with a particular diffing-problem, where the
existing gems did not give me what I wanted.

A welcome by-product was the chance to learn a bit about comparing strings :)


How to use it
----------

1. Require the file "StringDiffer.rb"
2. diff = StringDiffer::SentenceDiff.new("sentence a", "sentence b")
3. "diff.differences" now contains the character positions where the sentences differ

See "manual_tests.rb" for complete examples.


How it works
----------

The diff is based on a home-brewn algorithm.

1) The sentences are split into words, which are then compared
2) The words that differ are then compared character-by-character

