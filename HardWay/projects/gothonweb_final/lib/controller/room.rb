class Room
	attr_accessor :name, :description, :paths, :message, :previousRoom, :score, :hint

	def initialize()
		@name = ""
		@description = ""
		@paths = {}
		@message = ""
		@previousRoom = ""
		@score=""
		@hint=""
	end

	# Misc methods
	def go(direction)
		@paths[direction]
	end

	def addPaths(paths)
		@paths.update(paths)
	end

	def cleanMessage()
		@message = ""
	end

	def getStartRoom()
	end

	def setMessage()
	end

	def getRoomHint()
	end

	
	def getHint()
	end

	def getStartRoom()
	end

	def getDeathRoom()
	end

	def getEndRoom()
	end
end