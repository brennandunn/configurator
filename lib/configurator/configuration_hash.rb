class ConfigurationHash < ActiveRecord::Base
  set_table_name 'config'
  
  belongs_to :associated, :polymorphic => true
  
  class << self
    
    def find_by_key_and_owner(call_type, key, owner, namespace = nil)
      options = namespace ? { :namespace => namespace } : {}
      find(:first, :conditions => { :key => key, 
                                    :associated_id => call_type == :instance ? owner.id : nil, 
                                    :associated_type => call_type == :instance ? owner.class.name : owner.name
                                   }.merge(options))
    end
    
    def find_all_by_owner(call_type, owner, namespace = nil)
      options = namespace ? { :namespace => namespace } : {}
      find(:all, :conditions => { :associated_id => call_type == :instance ? owner.id : nil, 
                                  :associated_type => call_type == :instance ? owner.class.name : owner.name 
                                  }.merge(options))
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