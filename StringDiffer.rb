# encoding: UTF-8

#
# Contains very basic string diffing classes.
#
module StringDiffer

	#
	# Finds the difference between two sentences
	# on a word basis
	#
	class WordDiff
	
		# A string array of the words in sentence A
		attr_accessor :a_words
		
		# A string array of the words in sentence B
		attr_accessor :b_words
		
		# An integer array with the "word" indices
		# where "a_words" and "b_words" are different
		attr_accessor :differences
		
		# Takes two sentences as parameters
		# and performs the comparison.
		#
		# The result of the diff is available
		# in the "differences" property
		def initialize(a, b)
			@a_words = []
			@b_words = []
			@differences = []
		
			run_diff(a, b)
		end
	
		# Run word-based diff between the sentences
		# given as parameters
		def run_diff(a, b)
			a = "" if a == nil
			b = "" if b == nil
	
			@a_words = a.split(" ")
			@b_words = b.split(" ")
	
			max = @a_words.length
			max = @b_words.length if @b_words.length > @a_words.length
	
			for i in 0..max-1
				@differences.push(i) if @a_words[i] != @b_words[i]
			end
			
			# return void
			return
		end
	end
	
	
	#
	# Find differences between two sentences.
	# The diff is able to find a difference
	# in something like the following:
	#
	# A: "Short sentence"
	# B: "Short, sentence"
	#
	# In that case, only the comma after "Short"
	# would be considered a difference
	#
	class SentenceDiff
	
		# Sentence A
		attr_accessor :a
		
		# Sentence B
		attr_accessor :b
		
		# An integer array with the character
		# positions that are different
		attr_accessor :differences
		
		# The underlying "WordDiff" instance
		attr_accessor :worddiff
	
		# Constructor taking the two sentences
		# to diff. The diff is run automatically
		def initialize(a, b)
			@a = ""
			@b = ""
			@b_linenumber = -1
			@differences = []
			@worddiff = WordDiff.new("", "")
		
			run_diff(a, b)
		end
	
		# Run diff on the two given sentences
		def run_diff(a, b)
			a = "" if a == nil
			b = "" if b == nil
		
			@a = a
			@b = b
		
			# run the initial word-based diff
			@worddiff = WordDiff.new(a, b)
		
			awords = @worddiff.a_words
			bwords = @worddiff.b_words
			wdiff = @worddiff.differences
		
			#
			# now run through all the words in the longest
			# of the sentences, and for words that differ
			# run a character based diff and calculate the differing
			# characters actual position within the sentences
			#
			max = awords.length
			max = bwords.length if bwords.length > awords.length
		
			str = ""
		
			for i in 0..max-1
		
				if wdiff.include?(i)
					diff_by_char(awords[i], bwords[i]).each do |chardiff|
						@differences.push(chardiff + str.length)
					end
				end
			
				str << " #{bwords[i]}"
			end

			# return void		
			return
		end
		
		# Run a character-by-character diff
		# between two given sentences
		#
		# The method returns an integer array
		# with the positions of the characters
		# that do not match
		def diff_by_char(a, b)
			differences = []
	
			a = "" if a == nil
			b = "" if b == nil
	
			max = a.length
			max = b.length if b.length > a.length
	
			for pos in 0..max-1
				differences.push(pos+1) if a[pos] != b[pos]
			end
	
			return differences
		end
	end
end
