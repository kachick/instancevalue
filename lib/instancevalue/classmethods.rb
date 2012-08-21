module InstanceValue

  module ClassMethods

    private
    
    def value_reader(name)
      define_method name do
        instance_value_get name
      end
    end

  end

end