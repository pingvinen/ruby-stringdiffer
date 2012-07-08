# encoding: UTF-8

require "./StringDiffer.rb"

# Simply carries the opposing sentences
class Test
	attr_accessor :a
	attr_accessor :b

	def initialize(a, b)
		@a = a
		@b = b
	end
end


# Prints the difference between the given
# sentences based on the given array of
# "difference indices"
def print_diff(a, b, differences)
	a = "" if a == nil
	b = "" if b == nil

	linemax = a.length
	linemax = b.length if b.length > a.length
	
	for pos in 0..linemax-1
		if differences.include?(pos+1)
			print "^"
		else
			print " "
		end
	end
	
	print "\n"
	
	return
end



#
#
# the test sentences
#
#
tests = [
	Test.new("Short sentence", "Short, sentence"),
	Test.new("Different casing", "DIFFERENT casing"),
	Test.new("Two completely", "Different sentences"),
	Test.new("No difference at all Bruce", "No difference at all Bruce")
]


# run diffs and output the results
tests.each do |test|

	diff = StringDiffer::SentenceDiff.new(test.a, test.b)
	
	puts "#{diff.a}"
	puts "#{diff.b}"
	print_diff(diff.a, diff.b, diff.differences)

	puts "\n"
end
