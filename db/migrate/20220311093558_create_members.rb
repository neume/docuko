class CreateMembers < ActiveRecord::Migration[6.1]
  REGULAR = 2
  ACTIVE = 1

  def change

    create_table :members do |t|
      t.bigint :office_id, index: true
      t.bigint :user_id, index: true

      t.datetime :invited_at

      t.integer :member_status, default: ACTIVE
      t.integer :member_role, default: REGULAR

      t.timestamps
    end
  end
end
