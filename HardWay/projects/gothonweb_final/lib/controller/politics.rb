require_relative "./room"

class PoliticsRoom < Room
    attr_accessor :name, :description, :paths, :message, :previousRoom

    def initialize(name,description)
        @name = name
        @description = description
        @paths = {}
        @message = ""
        @previousRoom = ""
    end

    def getStartRoom()
        
    end
end
