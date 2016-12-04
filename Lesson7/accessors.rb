module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name_history, []) unless instance_variable_get(var_name_history)
        instance_variable_set(var_name, value)
        history = instance_variable_get(var_name_history)
        history << instance_variable_get(var_name)
        instance_variable_set(var_name_history, history)
      end

      define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) }
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      if value.class.to_s == type.to_s
        instance_variable_set(var_name, value)
      else
        raise 'Неправильный тип переменной, значение не будет присвоено.'
      end
    end
  end
end
