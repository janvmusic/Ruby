module Ex25
	def self.break_words(stuffs)
		#This function will break up words for if ARGV.
		words = stuffs.split(' ')
		words
	end

	def self.sort_words(words)
		words.sort()
	end

	def self.print_first_word(words)
		word = words.shift()
		puts word
	end

	def self.print_last_word(words)
		word = words.pop
		puts word
	end

	def self.sort_sentece(sentece)
		words = break_words(sentence)
		print_first_word(words)
		print_last_word(words)		
	end

	def self.print_first_and_last_sorted(sentence)
		words = sort_sentece(sentence)
		print_first_word(words)
		print_last_word(words)
	end
end
