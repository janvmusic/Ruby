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

	def convert_number(s)
		begin
			Integer(s)
		rescue ArgumentError
			nil
		end
	end

	def scan(stuffs)
		words = stuffs.split()
		result = []
		for word in words
			if DIRECTION.has_value?(word)
				key = DIRECTION.key(word)
				result << Pair.new(:direction, DIRECTION[key])
			elsif VERBS.has_value?(word)
				key = VERBS.key(word)
				result << Pair.new(:verb,VERBS[key])
			elsif STOP_WORDS.has_value?(word)
				key = STOP_WORDS.key(word)
				result << Pair.new(:stop,STOP_WORDS[key])
			elsif NOUNS.has_value?(word)
				key = NOUNS.key(word)
				result << Pair.new(:noun,NOUNS[key])
			elsif convert_number(word)
				result << Pair.new(:number,word)
			else
				result << Pair.new(:error,word)
			end
		end
		return result
	end
end

