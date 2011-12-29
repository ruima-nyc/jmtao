class CreateTaobaoItems < ActiveRecord::Migration
  def self.up
    create_table :taobao_items do |t|
      t.string :url
      t.decimal :price, :precision => 15, :scale => 2
      t.integer :num_iid
      t.integer :article_id
      t.integer :resource_id

      t.timestamps
    end
  end

  def self.down
    drop_table :taobao_items
  end
end
