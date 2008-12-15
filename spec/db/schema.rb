ActiveRecord::Schema.define(:version => 0) do
  create_table :accounts, :force => true do |t|
    t.text :encoded_preferences
    t.text :encoded_text_field
    t.string :encoded_string_field
    t.integer :encoded_integer_field
  end
end
