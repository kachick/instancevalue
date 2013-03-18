# instancevalue - Constant values for each instance.
#   Copyright (C) 2012 Kenichi Kamiya

require_relative 'instancevalue/version'
require_relative 'instancevalue/classmethods'
require_relative 'instancevalue/singleton_class'

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
#         (Time.now - birthday) / (60 * 60 * 24 * 365)
#       end
#     end
#     
#     person = Person.new YOUR_BIRTHDAY
#     person.birthday                               #=> YOUR_BIRTHDAY
#     person.age                                    #=> age at runtime
#     person.instance_eval{val :birthday, Time.now} #=> Exception
module InstanceValue

  VALUES_KEYSTORE_NAME = :VALUES_KEYSTORE

  # @param [Symbol, String] name
  def instance_value_defined?(name)
    raise TypeError unless name.instance_of?(Symbol) or name.respond_to?(:to_str)
    
    _values.has_key? name.to_sym
  end
  
  # @param [Symbol, String] name
  def instance_value_get(name)
    instance_value_defined?(name) ? _values[name.to_sym] : nil
  end
  
  # @param [Symbol, String] name
  # @return [value]
  def instance_value_set(name, value)
    raise "value(#{name}) was already bound" if instance_value_defined? name

    _values[name.to_sym] = value
  end
  
  # @return [Array<Symbol>]
  def instance_values
    _values.keys
  end
  
  # @return [String]
  def inspect
    super.sub(/>\z/){
      _values.map{|name, value|
        " #{name}=#{value.inspect}"
      }.join + '>'
    }
  end
  
  protected
  
  def _values
    if singleton_class.const_defined? VALUES_KEYSTORE_NAME
      singleton_class.const_get VALUES_KEYSTORE_NAME
    else
      singleton_class.const_set VALUES_KEYSTORE_NAME, {}
    end
  end
  
  private
  
  def initialize_copy(original)
    singleton_class.const_set VALUES_KEYSTORE_NAME, original._values.dup
  end
  
  def remove_instance_value(name)
    if instance_value_defined? name
      _values.delete name.to_sym
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