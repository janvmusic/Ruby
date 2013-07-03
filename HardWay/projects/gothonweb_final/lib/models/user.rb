require 'rubygems'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

DataMapper.setup(:default,"postgres://localhost/sinatra_login")

class User
    include DataMapper::Resource
    include BCrypt

    property :id, Serial, :key => true
    property :username, String, :length => 3..50
    property :password, BCryptHash
end

DataMapper.finalize
DataMapper.auto_upgrade!