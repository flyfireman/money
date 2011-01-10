class CreateCaps < ActiveRecord::Migration
  def self.up
    create_table :caps do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :caps
  end
end
