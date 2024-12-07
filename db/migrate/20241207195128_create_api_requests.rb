class CreateApiRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :api_requests do |t|
      t.references :target, null: false, polymorphic: true
      t.string :target_url, null: false
      t.boolean :success, null: false
      t.json :request_body
      t.json :response_body
      t.integer :response_code

      t.timestamps
    end
  end
end
