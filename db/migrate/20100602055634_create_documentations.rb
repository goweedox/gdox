#require "migration_helpers"
class CreateDocumentations < ActiveRecord::Migration
  #extend MigrationHelpers  # see lib/migration_helpers.rb
  def self.up
    create_table :documentations do |t|
      t.integer :user_id, :null => false
      t.string :title
      t.text :description

      t.timestamps
    end
    #execute "alter table users add column documentation_id int after id;"
    #foreign_key :users, :id, :documentations, :user_id, 'RESTRICT'
  end

  def self.down
    #drop_foreign_key :users, :documentations
    drop_table :documentations
    #remove_column :documentations, :id
  end
end
