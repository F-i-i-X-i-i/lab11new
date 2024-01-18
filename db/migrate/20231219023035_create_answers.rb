class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.integer :n
      t.string :result

      t.timestamps
    end
  end
end
