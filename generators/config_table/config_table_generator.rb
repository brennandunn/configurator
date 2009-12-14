class ConfigTableGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template "migration/create_config_table.rb", "db/migrate"
    end
  end
  
  def file_name
    "create_config_table"
  end
end