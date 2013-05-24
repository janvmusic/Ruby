require_relative "gothonweb_final/version"
require_relative "map"
require "sinatra"
require "erb"

use Rack::Session::Pool

get '/' do
    # This is used to "setup" the session with starting values
    p START
    session[:room] = START
    redirect("/game")
end

get '/game' do 
    if session[:room]
        erb :show_room, :locals => {:room => session[:room]}
    else
        # Why is this here? do you need it?
        erb :you_died
    end 
end

post '/game' do
    action = "#{params[:action] || nil}"
    # There is a bug here, can you fix it?
    if session[:room]
        session[:room] = session[:room].go(params[:action])
        
        #check for the death message
        if session[:room] == nil
            session[:room] = DEATH
        elsif session[:room].get_name() == 'death'
            session[:room].set_message(params[:action])
        elsif session[:room].get_name() == 'Laser Weapon Armory'
            session[:room].set_message('hint')
        end
    end
    redirect("/game")
end