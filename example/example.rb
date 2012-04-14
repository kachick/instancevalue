$VERBOSE = true

require_relative '../lib/instancevalue'

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

person = Person.new Time.at 8888
p person.birthday
p person.age                                    #=> age at runtime
#~ person.instance_eval{val :birthday, Time.now} #=> Exception