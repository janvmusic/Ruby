require_relative "gothonweb_final/version"
require_relative "controller/map"
require "sinatra"
require "erb"
require "rubygems"
require_relative "models/user"
use Rack::Session::Pool

# ADDED 
set :username, ''
set :token, 'shakenN0tstirr3d'
set :password, ''

# TO-DO: Dude you have to put comments on these lines
helpers do 
    def admin? 
        request.cookies[settings.username] == settings.token
    end

    def protected!
        halt [ 401, 'Not Authorized' ] unless admin?
    end
end
# ADDED 

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
            puts "MAZAPAN did I get here?"
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
        "Username/Password required"
    else
        @user = User.first(username)
    end

    if @user == nil
        "Username or Password incorrect"
    elsif @user.username == params['username'] && @user.password == params['password']
        puts @user.username

        response.set_cookie(@user.username, settings.token)
        settings.username = @user.username
        p START
        session[:room] = START
        redirect("/")
    else 
        "Username or Password incorrect"
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
    response.set_cookie(settings.username,false)
    redirect '/'
end

get '/public' do
    erb :public
end

get '/private' do
    protected!
    # 'For your eyes only!'
    erb :private
end
# ADDED