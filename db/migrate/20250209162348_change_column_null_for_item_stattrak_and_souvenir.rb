class ChangeColumnNullForItemStattrakAndSouvenir < ActiveRecord::Migration[7.2]
  def change
    change_column_null :items, :stattrak, true
    change_column_null :items, :souvenir, true
  end
end
