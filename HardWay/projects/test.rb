require 'rubygems'
require 'sinatra'
require 'erb'

module Test1 
    get '/' do
        greeting = "Hello world!"
        # erb :index, :locals => {:greeting => greeting}
        return greeting
    end
end