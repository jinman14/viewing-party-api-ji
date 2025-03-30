class CreateViewingInvites < ActiveRecord::Migration[7.1]
  def change
    create_table :viewing_invites do |t|
      t.references :viewing_party, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
