class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.integer :documentation_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end
