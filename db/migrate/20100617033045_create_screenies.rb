class CreateScreenies < ActiveRecord::Migration
  def self.up
    create_table :screenies do |t|
      t.string :filename
      t.integer :dox_id
      t.timestamps
    end
  end

  def self.down
    drop_table :screenies
  end
end
