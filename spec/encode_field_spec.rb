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
end
