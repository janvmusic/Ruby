class Room
	attr_accessor :name, :description, :paths, :message, :previousRoom

	def initialize()
		@name = ""
		@description = ""
		@paths = {}
		@message = ""
		@previousRoom = ""
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
end