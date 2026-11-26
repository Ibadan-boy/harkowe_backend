class CreateWritings < ActiveRecord::Migration[8.0]
  def change
    create_table :writings do |t|
      
      t.string :title
      t.jsonb :content
      t.string :status, default: "draft", null: false
      t.references :user, null: false, foreign_key: true
      t.uuid :document_id, default: -> { "gen_random_uuid()" }, null: false

      t.timestamps
    end
    add_index :writings, :document_id, unique: true
  end
end
