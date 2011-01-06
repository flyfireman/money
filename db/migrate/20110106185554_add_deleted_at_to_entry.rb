class AddDeletedAtToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :deleted_at, :datetime
  end

  def self.down
    remove_column :entries, :deleted_at
  end
end
