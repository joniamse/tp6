class CreateTurns < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
