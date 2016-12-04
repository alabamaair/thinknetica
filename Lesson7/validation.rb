module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :rules

    def validate(name, type, *args)
      @rules ||= []
      @rules << { type: type, name: name, args: args }
    end
  end

  module InstanceMethods

    def validate!
      self.class.rules.each do |rule|
        send rule[:type], rule[:name], rule[:args]
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    protected

    def presence(name, *_args)
      raise "Параметр @#{name} не может быть пустым" if instance_variable_get("@#{name}").to_s.empty?
    end

    def format(name, args)
      raise "Номер объекта имеет неправильный формат, проверяется соответствие с #{args[0]}" if instance_variable_get("@#{name}") !~ args[0]
    end

    def type(name, args)
      raise 'Заданный атрибут не соответствует классу' unless instance_variable_get("@#{name}").class == args[0]
    end
  end
end
