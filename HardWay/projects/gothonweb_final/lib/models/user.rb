require 'rubygems'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-validations'
require 'bcrypt'

DataMapper.setup(:default,"postgres://jnunez2:test@localhost/nc_game")

class User
    include DataMapper::Resource
    include BCrypt

    property :id, Serial
    property :username, String, :length => 3..50, :key => true, :unique => true, :required => true
    property :password, BCryptHash, :required => true
    property :score, Integer, :default => 0 

    validates_presence_of :username
    validates_uniqueness_of :username
end

DataMapper.finalize
DataMapper.auto_upgrade!