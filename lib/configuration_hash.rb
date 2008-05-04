class ConfigurationHash < ActiveRecord::Base
  set_table_name 'config'
  
  belongs_to :associated, :polymorphic => true
  
  class << self
    
    def find_by_key_and_owner(key, owner)
      find(:first, :conditions => { :key => key, :associated_id => owner.id, :associated_type => owner.class.name })
    end
    
    def find_all_by_owner(owner)
      find(:all, :conditions => { :associated_id => owner.id, :associated_type => owner.class.name })
    end
    
  end
  
  def value=(param)
    write_attribute :value, param.to_s
  end
  
  def value
    if key.ends_with? "?"
      read_attribute(:value) == "true"
    else
      read_attribute(:value)
    end
  end
  
end