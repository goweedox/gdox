class CreateScreenshots < ActiveRecord::Migration
  def self.up
    create_table :screenshots do |t|
			t.references :documentation
      t.timestamps
    end
		add_index :screenshots, :documentation_id
  end

  def self.down
    drop_table :screenshots
  end
end
