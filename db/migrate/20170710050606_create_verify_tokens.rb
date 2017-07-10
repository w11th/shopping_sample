class CreateVerifyTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :verify_tokens do |t|
      t.string :token
      t.string :cellphone
      t.datetime :expire_at

      t.timestamps
    end

    add_index :verify_tokens, [:cellphone, :token]
  end
end
