module InstanceCounter
  def self.included(base)
    base.instance_variable_set :@instances, 0
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    private

    attr_writer :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send(:instances=, self.class.instances + 1)
    end
  end
end
