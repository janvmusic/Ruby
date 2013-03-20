class Lexicon 
	Pair = Struct.new(:token, :word)

	DIRECTION = {
		:north => "north",
		:south => "south",
		:east => "east",
		:west => "west",
		:down => "down",
		:up => "up",
		:left => "left",
		:right => "right",
		:back =>"back"
	}

	VERBS = {
		:go => "go",
		:stop => "stop",
		:kill => "kill",
		:eat => "eat"
	}

	STOP_WORDS = {
		:the => "the",
		:in => "in",
		:of => "of",
		:from => "from",
		:at => "at",
		:it => "it"
	}

	NOUNS = {
		:door => "door",
		:bear => "bear",
		:princess => "princess",
		:cabinet => "cabinet"
	}

	def initialize()
		
	end

	def scan(stuffs)
		words = stuffs.split()

		for word in words
			if DIRECTION.has_value?(word)
				puts Pair.new(DIRECTION.key(word), word)
			elsif VERBS.has_value?(word)
				puts Pair.new(VERBS.key(word), word)
			elsif STOP_WORDS.has_value?(word)
				puts Pair.new(STOP_WORDS.key(word), word)
			elsif NOUNS.has_value?(word)
				puts Pair.new(NOUNS.key(word), word)
			else
				puts "Error!"
			end
		end
	end
end

lexi = Lexicon.new
lexi.scan("go north")
