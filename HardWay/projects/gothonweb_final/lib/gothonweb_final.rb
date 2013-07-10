require_relative "gothonweb_final/version"
require_relative "controller/map"
require_relative "models/user"
require "sinatra"
require 'sinatra/flash'
require "erb"
require "rubygems"
use Rack::Session::Pool

set :username, ''
set :token, 'shakenN0tstirr3d'
set :password, ''
set :error, false
set :errorMessage, ''

# TO-DO: Dude you have to put comments on these lines
helpers do 
    def admin? 
        request.cookies[settings.username] == settings.token
    end

    def protected!
        # halt [ 401, 'Not Authorized' ] unless admin?
        redirect("/privateLogin") unless admin?
    end

    def logout
        response.set_cookie(settings.username,false)
    end
end

# TO-DO: Dude you have to put comments on these lines
get '/game' do 
    if session[:room]
        if session[:room].name == 'Game Over' && session[:room].message == ""
            session[:room] = START
            erb :show_room, :locals => {:room => session[:room]}
        else
            erb :show_room, :locals => {:room => session[:room]}
        end
    else
        # If any weird issue just die
        erb :you_died
    end 
end

post '/game' do
    action = "#{params[:action] || nil}"

    # Let's save the previous room name
    previousRoom = session[:room].name

    if session[:room]
        session[:room] = session[:room].go(params[:action])
      
        # If the room is empty well, lets declare it as a death
        if session[:room] == nil
            session[:room] = DEATH
            session[:room].setMessage('gameOver')
            
            # If the last room was Laser and he got the wrong code well you are dead xD
            if previousRoom == 'Laser Weapon Armory'
                session[:room].setMessage('wrongCode')
        
            # If the last room was the bridge and he did the wrong action
            elsif previousRoom == 'The Bridge'
                session[:room].setMessage('bridgeDeath')
            end
        
        # Ok the room is not nil right? but well the room is Game Over! D:!
        elsif session[:room].name == 'Game Over'
            # Got the corresponding message!
            session[:room].setMessage(params[:action])
        
        # Room not nil and well it has a name! laser! bzzzz
        elsif session[:room].name == 'Laser Weapon Armory'
            session[:room].setMessage('hint')
        
        elsif session[:room].name == 'Wrong Pod'
            session[:room].setMessage('wrongPod')
        end
    end

    # Set the previous room
    session[:room].previousRoom = previousRoom
    redirect("/game")
end

# TO-DO: Dude you have to put comments on these lines
post '/login' do
    username = params['username']
    password = params['password']

    if username == nil || password == nil
        settings.error = true
        settings.errorMessage = "Incorrect Username/Password"
        redirect("/admin")
    else
        @user = User.first(:username=>username)
    end

    if @user == nil
        settings.error = true
        settings.errorMessage = "Incorrect Username/Password"
        redirect("/admin")
    elsif @user.username == params['username'] && @user.password == params['password']
        response.set_cookie(@user.username, settings.token)
        settings.username = @user.username
        settings.error = false
        settings.errorMessage = ""
        p START
        session[:room] = START
        redirect("/")
    else 
        settings.error = true
        settings.errorMessage = "Incorrect Username/Password"
        redirect("/admin")
    end
end

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
        @user = User.new
        @user.attributes = {:username => username,:password => password}
        if @user.save
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
        @user = User.first(:username=>username)
        puts @user.username
        puts @user.password
        puts username
        puts password

        @user.attributes = {:username => username,:password => password}
        if @user.update
            settings.error = true
            settings.errorMessage = "Success: The username was updated!"
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
    erb :profile
end

get '/profile#updated' do
    erb :profile
end

get '/events' do
    erb :events
end

get '/faq' do
    erb :faq
end

get '/contact' do
    erb :contact
end

get '/privateLogin' do
    erb :privateError
end