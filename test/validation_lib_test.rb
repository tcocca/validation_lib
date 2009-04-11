require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../shoulda_macros/validation_lib'

class ValidationLibTest < Test::Unit::TestCase
  
  should_validate_as_email_klass(Tester, :email)
  should_validate_as_zip_code_klass(Tester, :email)
  should_validate_as_phone_klass(Tester, :email)
  
end



class TestRecord < ActiveRecord::Base
  def self.columns; []; end
  attr_accessor :phone, :email, :zip_code
  validates_as_phone :phone
  validates_as_email :email
  validates_as_zip_code :zip_code
end

class ValidatesAsEmailTest < Test::Unit::TestCase
  def test_illegal_emails
    emails = [
      'Max@Job 3:14', 
      'Job@Book of Job',
      'J. P. \'s-Gravezande, a.k.a. The Hacker!@example.com'
    ]
    emails.each do |email|
      assert !TestRecord.new(:email => email).valid?, "#{email} should be illegal."
    end
  end

  def test_legal_emails
    emails = [
      'test@example',
      'test@example.com', 
      'test@example.co.uk',
      '"J. P. \'s-Gravezande, a.k.a. The Hacker!"@example.com',
      'me@[187.223.45.119]',
      'someone@123.com'
    ]
    emails.each do |email|
      assert TestRecord.new(:email => email).valid?, "#{email} should be legal."
    end
  end
end

class ValidatesAsPhoneTest < Test::Unit::TestCase
  def test_valid_phone_numbers
    phones = [
      '123-123-1234',
      '123 123 1234',
      '123.123.1234',
      '123-123.3455',
      '123.123-1234',
      '(123) 123-1234',
      '123 123.1234',
      '123-123 1234',
      '123.123 1234',
      '123 123-1234',
      '(123) 123.1234',
      '(123) 123 1234'
    ]
    phones.each do |phone|
      assert TestRecord.new(:phone => phone).valid?, "#{phone} should be valid"
    end
  end
  
  def test_invalid_phone_numbers
    phones = [
      '123 123 123',
      '2233 12 1234',
      '(123)123-1234',
      '(123).123.1234',
      '(123)-123-1234'
    ]
    phones.each do |phone|
      assert !TestRecord.new(:phone => phone).valid?, "#{phone} should not be valid"
    end
  end
end

class ValidatesAsZipCodeTest < Test::Unit::TestCase
  def test_valid_zip_codes
    zips = [
      '55555',
      '55555-1234'
    ]
    zips.each do |zip|
      assert TestRecord.new(:zip_code => zip).valid?, "#{zip} should be valid"
    end
  end
  
  def test_invalid_zip_codes
    zips = [
      '5555',
      '55555-123',
      '12345 1234',
      '1234-1234'
    ]
    zips.each do |zip|
      assert !TestRecord.new(:zip_code => zip).valid?, "#{zip} should not be valid"
    end
  end
end
