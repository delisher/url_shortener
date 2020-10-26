class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls, comment: 'URL' do |t|
      t.string :slug, null: false, comment: 'Уникальный идентификатор коротких URL'
      t.string :original_url, null: false, comment: 'Оригинальный URL'
      t.integer :hits, null: false, default: 0, comment: 'Количество переходов по ссылке'

      t.timestamps
    end

    add_index :urls, :slug, unique: true
    add_index :urls, :original_url, unique: true
  end
end
