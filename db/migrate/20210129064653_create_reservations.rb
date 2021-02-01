class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :username
      t.string :resdate
      t.string :restime

      t.timestamps
    end
  end
end
