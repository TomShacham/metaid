class Object
# The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end
  def meta_eval &blk; metaclass.instance_eval &blk; end

  # Adds methods to a metaclass
  def meta_def name, &blk
   meta_eval { define_method name, &blk }
  end

  # Defines an instance method within a class
  def class_def name, &blk
   class_eval { define_method name, &blk }
  end
end

class Creature
  def self.traits( *arr )
    return @traits if arr.empty?
    attr_accessor *arr
    arr.each do |trait|
      meta_def trait do |val|
        @traits ||= {}
        @traits[trait] = val
      end
    end
    class_def :initialize do
      self.class.traits.each do |k,v|
        instance_variable_set( "@#{k}", v )
      end
    end
  end
end

class Rabbit < Creature
  traits :bombs, :arrows
  def a
  end
end

p Creature.methods.first
p Rabbit.singleton_methods


