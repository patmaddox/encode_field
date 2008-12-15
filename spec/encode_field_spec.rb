require File.dirname(__FILE__) + '/spec_helper'

describe "encode_field" do
  class Account < ActiveRecord::Base
    encode_field :preferences
  end

  it "should encode and retrieve" do
    prefs = {:type => 'platinum', "email" => "joe@example.com", :age => 23}
    Account.create! :preferences => prefs
    Account.find(:first).preferences.should == prefs
  end

  it "should define query methods" do
    Account.new.preferences?.should be_false
    Account.new(:preferences => "foobar").preferences?.should be_true
  end

  it "should handle nil preferences okay" do
    Account.new.preferences.should be_nil
  end

  it "should print a message if the database field doesn't exist" do
    lambda {
      Account.class_eval { encode_field :whereswaldo }
    }.should raise_error(/The field 'encoded_whereswaldo' does not exist/)
  end

  it "should print a message if the database field is not a string or text" do
    lambda {
      Account.class_eval { encode_field :text_field }
    }.should_not raise_error

    lambda {
      Account.class_eval { encode_field :string_field }
    }.should_not raise_error

    lambda {
      Account.class_eval { encode_field :integer_field }
    }.should raise_error(/'encoded_integer_field' must be of type :string or :text but is :int/)
  end
end
