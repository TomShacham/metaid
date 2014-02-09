require_relative 'metaid'

class MyClass
  class << self
    def attr_killer *args
      class_eval do
        args.each do |arg|
          define_method(arg) { instance_variable_set("@#{arg}", nil) }
          define_method("#{arg}=") { |val| instance_variable_set("@#{arg}", nil) }
        end
      end
    end
  end
end

#now we can define dead attribute readers and writers

class MyBoat < MyClass
  attr_killer :wood, :mast, :crew
end

floating_wreckage = MyBoat.new
p floating_wreckage.wood, floating_wreckage.mast, floating_wreckage.crew

#even if we try and define a val we get nil! ha ha!
floating_wreckage.wood = 'More lumber!'; p floating_wreckage.wood

#--- instead of relying on inheritance from MyClass
#wouldn't it be nice if attr_killer was defined on
#the fly for instances of MyBoat, so we could sink individual ships?
hms_noob = MyBoat.new
hms_noob.metaclass.meta_def(:attr_wrecker) do |*args|
  args.each do |arg|
    define_method(arg) { instance_variable_set("@#{arg}", 'wrecked!') }
  end
end

p hms_noob.metaclass.methods
p hms_noob.methods

