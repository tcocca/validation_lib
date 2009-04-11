$:.unshift(File.dirname(__FILE__) + '/../lib')
 
require 'rubygems'
require 'active_record'
require 'active_record/base'
 
require 'validation_lib'
 
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:')
 
ActiveRecord::Schema.define(:version => 0) do
  create_table :testers, :force => true do |t|
    t.string :email, :zip_code, :phone
  end
end
 
class Tester < ActiveRecord::Base
  validates_as_email :email
  validates_as_zip_code :zip_code
  validates_as_phone :phone
end
 
require 'test/unit'
require 'shoulda'
require "#{File.dirname(__FILE__)}/../init"

class Test::Unit::TestCase
  def self.should_allow_email_values(klass,*good_values)
    good_values.each do |v|
      should "allow email to be set to #{v.inspect}" do
        user = klass.new(:email => v)
        user.save
        assert_nil user.errors.on(:email)
      end
    end
  end
 
  def self.should_not_allow_email_values(klass,*bad_values)
    bad_values.each do |v|
      should "not allow email to be set to #{v.inspect}" do
        user = klass.new(:email => v)
        assert !user.save, "Saved user with email set to \"#{v}\""
        assert user.errors.on(:email), "There are no errors set on email after being set to \"#{v}\""
      end
    end
  end
  
  def self.should_allow_zip_code_values(klass,*good_values)
    good_values.each do |v|
      should "allow zip code to be set to #{v.inspect}" do
        user = klass.new(:zip_code => v)
        user.save
        assert_nil user.errors.on(:zip_code)
      end
    end
  end
 
  def self.should_not_allow_zip_code_values(klass,*bad_values)
    bad_values.each do |v|
      should "not allow zip code to be set to #{v.inspect}" do
        user = klass.new(:zip_code => v)
        assert !user.save, "Saved user with zip code set to \"#{v}\""
        assert user.errors.on(:zip_code), "There are no errors set on zip code after being set to \"#{v}\""
      end
    end
  end
  
  def self.should_allow_phone_values(klass,*good_values)
    good_values.each do |v|
      should "allow phone to be set to #{v.inspect}" do
        user = klass.new(:phone => v)
        user.save
        assert_nil user.errors.on(:phone)
      end
    end
  end
 
  def self.should_not_allow_phone_values(klass,*bad_values)
    bad_values.each do |v|
      should "not allow phone to be set to #{v.inspect}" do
        user = klass.new(:phone => v)
        assert !user.save, "Saved user with phone set to \"#{v}\""
        assert user.errors.on(:phone), "There are no errors set on phone after being set to \"#{v}\""
      end
    end
  end
end
