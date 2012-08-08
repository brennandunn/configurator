class CreateConfigTable < ActiveRecord::Migration
  def up
    create_table :config do |t|
      t.references    :associated, :polymorphic => true
      t.string        :namespace
      t.string        :key,         :limit => 40,     :null => false
      t.string        :value
      t.string        :data_type,   :limit => 40
    end
  end

  def down
    drop_table :config
  end
end