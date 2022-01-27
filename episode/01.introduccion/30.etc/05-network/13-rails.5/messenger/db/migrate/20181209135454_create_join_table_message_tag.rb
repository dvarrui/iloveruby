class CreateJoinTableMessageTag < ActiveRecord::Migration[5.2]
  def change
    create_join_table :messages, :tags do |t|
      # t.index [:message_id, :tag_id]
      # t.index [:tag_id, :message_id]
    end
  end
end
