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
        @user.attributes = {:username => username,:password => password}
        
        if @user.save
            return true
        else 
            return false
        end
    end

    # User update password
    def update(username,password)
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
        @user = User.first(:username=>username)
        
        if @user == nil
            return false    
        elsif @user.update(:username => username,:score => score)
            return true
        else
            return false
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
end