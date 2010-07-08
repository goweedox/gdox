class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
			t.float :x_coord
			t.float :y_coord
			t.integer :response_time

      t.timestamps
    end
  end

  def self.down
    drop_table :annotations
  end
end
