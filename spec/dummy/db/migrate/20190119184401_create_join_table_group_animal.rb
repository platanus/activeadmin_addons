class CreateJoinTableGroupAnimal < ActiveRecord::Migration
  def change
    create_join_table :groups, :animals do |t|
      t.index [:group_id, :animal_id]
    end
  end
end
