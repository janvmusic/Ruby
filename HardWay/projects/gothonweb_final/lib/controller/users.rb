require_relative "../models/user"

class UserController
    attr_accessor :username, :password, :score, :logged

    # Constructor
    def initialize()
        @username = ""
        @password = ""
        @score = 0
        @logged = false
    end

    # User register
    def register(username,password)

        if username == "" && password = "" || username == nil && password = nil
            return false
        end

        @user = User.new
        @user.attributes = {:username => username,:password => password}
        
        if @user.save
            return true
        else 
            return false
        end
    end

    # User update password
    def updatePassword(username,password)

        if username == "" && password = "" || username == nil && password = nil
            return false
        end

        @user = User.first(:username=>username)
        
        if @user == nil
            return false    
        elsif @user.update(:username => username,:password => password)
            return true
        else
            return false
        end
    end

    # User update score
    def update(username,score)

        if username == "" && score = "" || username == nil && score = nil
            return false
        end

        @user = User.first(:username=>username)
        
        if @user == nil
            return false 
        else
            score += @user.score
            
            if @user.update(:username => username,:score => score)
                return true
            else
                return false
            end
        end
    end

    # User login
    def login(username,password)
        @user = User.first(:username=>username)
        
        if @user == nil
            return false
        elsif @user.username == username && @user.password == password
            @username = @user.username
            @score = @user.score
            @logged = true
            return true
        else 
            return false
        end
    end

    # Get user score
    def getScore(username)

        if username == "" || username == nil
            return 0
        end

        @user = User.first(:username=>username)

        if @user == nil
            return 0
        else 
            return @user.score
        end
    end
end