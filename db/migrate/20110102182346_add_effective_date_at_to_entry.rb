class AddEffectiveDateAtToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :effective_date_at, :date
  end

  def self.down
    remove_column :entries, :effective_date_at
  end
end
