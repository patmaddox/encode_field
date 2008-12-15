ActiveRecord::Schema.define(:version => 0) do
  create_table :accounts, :force => true do |t|
    t.text :encoded_preferences
  end
end
