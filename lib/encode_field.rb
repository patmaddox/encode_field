module EncodeField
  def encode_field(field_name)
    column = columns.detect {|c| c.name == "encoded_#{field_name}" }
    if column.nil?
      raise "The field 'encoded_#{field_name}' does not exist"
    elsif ![:string, :text].include?(column.type)
      raise "'encoded_#{field_name}' must be of type :string or :text but is :#{column.type}"
    end
    
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
