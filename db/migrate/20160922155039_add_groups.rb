class AddGroups < ActiveRecord::Migration
  def change
    create_table :groups, force: true do |t|
      t.string :name
    end
  end
end
