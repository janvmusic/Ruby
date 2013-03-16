class Lexicon 

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
	end
end

lexi = Lexicon.new
lexi.scan("bear mazapan tonto")
