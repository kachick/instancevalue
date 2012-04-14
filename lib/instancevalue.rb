# Instance Value
#   Set constant values for each instance.
#   Copyright (C) 2012  Kenichi Kamiya

# @example Overview
#     class Person
#       include InstanceValue
#       
#       value_reader :birthday
#
#       def initialize(birthday)
#         val :birthday, birthday
#       end
#
#       def age
#         (Time.now - val(:birthday)) / (60 * 60 * 24 * 365)
#       end
#     end
#     
#     person = Person.new YOUR_BIRTHDAY
#     person.birthday                               #=> YOUR_BIRTHDAY
#     person.age                                    #=> age at runtime
#     person.instance_eval{val :birthday, Time.now} #=> Exception
module InstanceValue
  VERSION = '0.0.2'.freeze

  module Eigen
    private
    
    def value_reader(name)
      define_method name do
        instance_value_get name
      end
    end
  end

  class << self
    private
    
    def included(mod)
      mod.extend Eigen
    end
  end

  def instance_value_defined?(name)
    unless name.instance_of?(Symbol) or name.respond_to?(:to_str)
      raise TypeError
    end
    
    if singleton_class.const_defined? :VALUES
      singleton_class::VALUES.has_key? name.to_sym
    else
      singleton_class.const_set :VALUES, {}
      false
    end
  end
  
  def instance_value_get(name)
    instance_value_defined?(name) ? singleton_class::VALUES[name.to_sym] : nil
  end
  
  def instance_value_set(name, value)
    if instance_value_defined? name
      raise "the value(#{name}) was already binded"
    else
      singleton_class::VALUES[name.to_sym] = value
    end
  end
  
  def instance_values
    singleton_class::VALUES.keys
  end
  
  private
  
  def remove_instance_value(name)
    if instance_value_defined? name
      singleton_class::VALUES.delete name.to_sym
    else
      raise NameError
    end
  end
  
  # @example
  #     val(name)        #=> get
  #     val(name, value) #=> set
  def val(name, *values)
    case values.length
    when 0
      instance_value_get name
    when 1
      instance_value_set name, values.first
    else
      raise ArgumentError, "wrong number of Argument #{values.length} for 1 or 2"
    end
  end
end