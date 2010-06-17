class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.integer :loc_x, :null => false
      t.integer :loc_y, :null => false
      t.integer :screen_id, :null => false     
      t.timestamps
    end
  end

  def self.down
    drop_table :annotations
  end
end
