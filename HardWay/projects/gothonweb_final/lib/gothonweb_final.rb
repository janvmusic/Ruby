# Requires inside the project
require_relative "gothonweb_final/version"
require_relative "controller/gothons"
require_relative "controller/politics"
require_relative "controller/users"

# Libraries requires
require "sinatra"
require 'sinatra/flash'
require "erb"
require "rubygems"
use Rack::Session::Pool

# Set the cookies
set :username, ''
set :token, 'AirGear'
set :error, false
set :errorMessage, ''
set :game,''
set :score,''
set :roomName,''

# Helpers
helpers do
    
    # Check if the user is logged in 
    def admin? 
        if session[:user] == nil
            return false
        else 
            return session[:user].logged
        end
    end

    # Check if the user can see the page
    def protected!
        redirect("/privateLogin") unless admin?
    end

    # Erase the user session
    def logout
        session[:user] = nil
    end

    # Erase the room session
    def cleanRoom
        session[:room] = nil
    end

    # Get updated user score
    def userScore
        settings.score = session[:user].getScore(settings.username)
    end

    # Get Room hint
    def roomHint()
        if session[:room] == nil
            "No hint available"
        else
            return session[:room].getRoomHint(session[:room].name)
        end
        
    end
end

# TO-DO: Comments & prepare this thing for more rooms
get '/game/:name' do 
    protected!
    if session[:room] == nil 
        if params[:name] == 'gothons'
            p GOTHONSTART
            settings.game = 'gothons'
            session[:room] = GOTHONSTART
        elsif params[:name] == 'politicsRage'
            p POLITICSSTART
            session[:room] = POLITICSSTART
            settings.game = 'gothons'
        end
    end

    if session[:room]
        if session[:room].name == 'Game Over' && session[:room].message == ""
            session[:room] = session[:room].getStartRoom()
            erb :show_room, :locals => {:room => session[:room]}
        else
            erb :show_room, :locals => {:room => session[:room]}
        end
    else
        # If any weird issue just die
        erb :you_died
    end 
end

# TO-DO: Comments & prepare this thing for more rooms
post '/game/:name' do
    action = "#{params[:action] || nil}"

    # Let's save the previous room name
    previousRoom = session[:room].name

    # If the room is empty well, lets declare it as a death
    if session[:room] == nil        
        session[:room] = session[:room].go('gameOver')
    elsif session[:room]
        session[:room] = session[:room].go(params[:action])

        if session[:room] == session[:room].getDeathRoom()
            # Set the previous room
            session[:room].previousRoom = previousRoom
            session[:room].setMessage(action)
        elsif session[:room].name == session[:room].getEndRoom()
            @user = UserController.new
            @user.update(settings.username,session[:room].score)
        else
            session[:room].setMessage(action)
        end 
    end
    redirect("/game/#{params[:name]}")
end

# Post action when a user tries to log in
post '/login' do

    # Gather Username & password
    username = params['username']
    password = params['password']

    # If username or password are null return error
    if username == nil || password == nil
        settings.error = true
        settings.errorMessage = "Incorrect Username/Password"
        redirect("/admin")
    else
        # In the case that username/password are not null
        # create a new user.
        session[:user] = UserController.new
    end

    # Login, we are delegating it to UserController.login
    # If this method return false, then error, else, true.
    if !session[:user].login(username,password)
        settings.error = true
        settings.errorMessage = "Incorrect Username/Password"
        redirect("/admin")
    else
        # Set cookies, first room then redirect to /
        settings.username = session[:user].username
        settings.error = false
        settings.errorMessage = ""
        redirect("/") 
    end
end

# Post action when a user tries to register
post '/register' do
    username = params['username']
    password = params['password']

    if username == "" || password == ""
        settings.error = true
        settings.errorMessage = "Error: All the fields must be filled"
        redirect("/register")
    elsif username == nil || password == nil
        settings.error = true
        settings.errorMessage = "Error: Username/Password null"
        redirect("/register")
    else
        session[:user] = UserController.new
        if session[:user].register
            settings.error = true
            settings.errorMessage = "Success: The username was created!"
            redirect("/register#new")
        else 
            settings.error = true
            settings.errorMessage = "Error: Username already created or an error ocurred"
            redirect("/register")
        end
    end
end

post '/profile' do
    username = params['username']
    password = params['password']

    if username == "" || password == ""
        settings.error = true
        settings.errorMessage = "All the fields must be filled"
        redirect("/profile")
    elsif username == nil || password == nil
        settings.error = true
        settings.errorMessage = "Error: Null Username/Password"
        redirect("/profile")
    else
        session[:user] = UserController.new
        if session[:user].update(username,password)
            settings.error = true
            settings.errorMessage = "Success: The password was updated!"
            redirect("/profile#updated")
        else 
            settings.error = true
            settings.errorMessage = "Error: An error ocurred"
            redirect("/profile")
        end
    end
end

# Simple gets
get '/' do
    cleanRoom
    erb :index
end

get '/admin' do
    erb :admin
end

get '/logout' do
    logout
    redirect '/'
end

get '/public' do
    erb :public
end

get '/private' do
    protected!
    erb :private
end

get '/register' do
    logout
    erb :register
end

get '/register#new' do
    logout
    erb :register
end

get '/profile' do
    userScore
    erb :profile
end

get '/profile#updated' do
    erb :profile
end

get '/contact' do
    erb :contact
end

get '/privateLogin' do
    erb :privateError
end