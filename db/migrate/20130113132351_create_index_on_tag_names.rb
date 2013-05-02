class CreateIndexOnTagNames < ActiveRecord::Migration
  def change
    add_index :tags, :name
  end
end
