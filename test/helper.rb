begin
  require File.dirname(__FILE__) + '/../../../../config/environment'
rescue LoadError
  require 'rubygems'
  require 'activerecord'
end

require File.join(File.dirname(__FILE__), '..', 'lib', 'configurator')
require File.join(File.dirname(__FILE__), '..', 'lib', 'configuration_hash')

class User < ActiveRecord::Base
  include Configurator
end

class Company < ActiveRecord::Base
  include Configurator
  
  default_configuration :notify_users? => true, :salary => { :default_for_manager => '$55,000', :default_for_employee => '$25,000' }
end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
 
def setup_db
  ActiveRecord::Schema.define(:version => 1) do

    create_table :config do |t|
      t.references    :associated, :polymorphic => true
      t.string        :namespace
      t.string        :key,         :limit => 40,     :null => false
      t.string        :value
    end
    
    create_table :users do |t|
      t.string        :handle
    end
    
    create_table :companies do |t|
      t.string        :name
    end

  end
end
 
def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end