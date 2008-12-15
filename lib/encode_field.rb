module EncodeField
  def encode_field(field_name)
    define_method("#{field_name}=") do |val|
      send("encoded_#{field_name}=", YAML.dump(val))
    end

    define_method(field_name) do
      (encoded = send("encoded_#{field_name}")) ? YAML.load(encoded) : nil
    end

    define_method("#{field_name}?") do
      send("encoded_#{field_name}?")
    end
  end
end

ActiveRecord::Base.extend EncodeField
