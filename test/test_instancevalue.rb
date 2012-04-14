$VERBOSE = true
require_relative 'test_helper'

class TestBasicCase < Test::Unit::TestCase
  class Person
    include InstanceValue
    
    value_reader :birthday

    def initialize(birthday)
      val :birthday, birthday
    end

    def age
      (Time.now - birthday) / (60 * 60 * 24 * 365)
    end
  end
  
  def test_normaly
    person = Person.new Time.at 8888
    assert_equal Time.at(8888), person.birthday
    assert_kind_of Float, person.age
    assert_equal [:birthday], person.instance_values

    assert_raises RuntimeError do
      person.instance_eval{val :birthday, Time.now}
    end
    
    assert_equal 'Ken', person.instance_eval{val :name, 'Ken'}
    assert_equal [:birthday, :name], person.instance_values
    
    assert_equal 'Ken', person.instance_eval{val :name}
    assert_equal 'Ken', person.instance_eval{remove_instance_value :name}
    assert_equal [:birthday], person.instance_values
    
    assert_equal nil, person.instance_eval{val :name}
    assert_equal 'John', person.instance_eval{val :name, 'John'}
    
    assert_raises NoMethodError do
      person.name
    end
  end
  
  def test_dup
    person = Person.new Time.now
    person2 = person.dup
    
    assert_equal person.instance_values, person2.instance_values
    
    person2.instance_value_set :newer, 123
    
    assert_same false, (person.instance_values == person2.instance_values)
  end
  
  def test_clone
    person = Person.new Time.now
    person2 = person.clone
    
    assert_equal person.instance_values, person2.instance_values
    
    person2.instance_value_set :newer, 123
    
    assert_same false, (person.instance_values == person2.instance_values)
  end
  
  def test_inspect
    person = Person.new 9753
    person.instance_variable_set :@var, 1234
    assert_equal true, !!(/\A#<TestBasicCase::Person:\w+ @var=1234 birthday=9753>\z/ =~ person.inspect)
  end
end
