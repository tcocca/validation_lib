module ValidationLib
  module Shoulda
    
    def should_validate_as_email(field)
      metaclass = (class << self; self; end)
      metaclass.send(:define_method,:should_allow_values) do |klass,*values|
        should_allow_values_for(field, *values)
      end
      metaclass.send(:define_method,:should_not_allow_values) do |klass, *values|
        should_not_allow_values_for(field, values)
      end
      should_validate_as_email_klass(model_class, field)
    end
    
    def should_validate_as_email_klass(klass, field)
      context 'Valid email' do
        should_allow_email_values(klass,
          'test@example',
          'test@example.com', 
          'test@example.co.uk',
          '"J. P. \'s-Gravezande, a.k.a. The Hacker!"@example.com',
          'me@[187.223.45.119]',
          'someone@123.com'
        )
      end
      
      context 'Invalid email' do
        should_not_allow_email_values(klass,
          'Max@Job 3:14', 
          'Job@Book of Job',
          'J. P. \'s-Gravezande, a.k.a. The Hacker!@example.com'
        )
      end
    end
    
    def should_validate_as_zip_code(field)
      metaclass = (class << self; self; end)
      metaclass.send(:define_method,:should_allow_values) do |klass,*values|
        should_allow_values_for(field, *values)
      end
      metaclass.send(:define_method,:should_not_allow_values) do |klass, *values|
        should_not_allow_values_for(field, values)
      end
      should_validate_as_zip_code_klass(model_class, field)
    end
    
    def should_validate_as_zip_code_klass(klass, field)
      context 'Valid email' do
        should_allow_zip_code_values(klass,
          '55555',
          '55555-1234'
        )
      end
      
      context 'Invalid email' do
        should_not_allow_zip_code_values(klass,
          '5555',
          '55555-123',
          '12345 1234',
          '1234-1234'
        )
      end
    end
    
    def should_validate_as_phone(field)
      metaclass = (class << self; self; end)
      metaclass.send(:define_method,:should_allow_values) do |klass,*values|
        should_allow_values_for(field, *values)
      end
      metaclass.send(:define_method,:should_not_allow_values) do |klass, *values|
        should_not_allow_values_for(field, values)
      end
      should_validate_as_phone_klass(model_class, field)
    end
    
    def should_validate_as_phone_klass(klass, field)
      context 'Valid email' do
        should_allow_phone_values(klass,
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
        )
      end
      
      context 'Invalid email' do
        should_not_allow_phone_values(klass,
          '123 123 123',
          '2233 12 1234',
          '(123)123-1234',
          '(123).123.1234',
          '(123)-123-1234'
        )
      end
    end
    
  end
end

Test::Unit::TestCase.extend(ValidationLib::Shoulda)
