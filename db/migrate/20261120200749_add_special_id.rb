class AddSpecialId < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :public_id, :uuid,
      default: -> { "gen_random_uuid()" },
      null: false

    add_index :users, :public_id, unique: true
  end
end
