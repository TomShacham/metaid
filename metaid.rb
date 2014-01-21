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


class MailTruck
  def initialize(name, bhp)
    @name, @bhp = name, bhp
    class << self
      def to_s
        'hi im a singleton method'
      end
    end
  end
end

m = MailTruck.new('m1',500)

p m.to_s

def m.a_singleton_method
  p self
end

