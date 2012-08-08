require 'rubygems'
require 'active_record'
require 'test/unit'
require 'configurator'
require 'shoulda'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

def setup_db
  ::ActiveRecord::Base.class_eval do
    silence do
      connection.create_table :config, :force => true do |t|
        t.references :associated, :polymorphic => true
        t.string :namespace
        t.string :key, :limit => 40, :null => false
        t.string :value
        t.string :data_type, :limit => 40
      end

      connection.create_table :users, :force => true do |t|
        t.string :handle
      end

      connection.create_table :companies, :force => true do |t|
        t.string :name
      end
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

setup_db

class User < ActiveRecord::Base
  include Configurator
end

class Company < ActiveRecord::Base
  include Configurator

  default_configuration :notify_users? => true, :salary => { :default_for_manager => '$55,000', :default_for_employee => '$25,000' }
end
