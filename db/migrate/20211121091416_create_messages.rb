class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
       t.references :user, foregn_key: true, null: false
       t.references :chat_room, foregn_key: true, null: false
       t.string :text, null: false

      t.timestamps
    end
  end
end
