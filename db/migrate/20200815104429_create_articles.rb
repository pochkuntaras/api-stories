class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :story, null: false, foreign_key: true

      t.string :name, null: false, index: true
      t.string :kind, null: false, index: true, default: 'standard_text'

      t.text :text, null: false

      t.timestamps
    end
  end
end
