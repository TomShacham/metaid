p '-------bank stuff --------'

class Bank
  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /^method_missing$|^__|object_id/
  end

  attr_reader :name

  def initialize name
    @name = name
  end

  def method_missing name, *args, &blk
    [].send name, *args, &blk
  end
end

p Bank.instance_methods

b = Bank.new('HSBC')

p b.class

p b.name.length

p '------- proxy stuff -------'

class Proxy
  def self.new( *args )
    class << array = Array.new(*args)
      p self
      def sweet
        "what a sweet method"
      end
    end
  array
  end
end

p Proxy.new
p Proxy.new.methods

p '------- A stuff --------'

class A
end
p A.instance_methods

class Simple < BasicObject
end

p Simple.instance_methods

p '----- overriding new and initialize ---------'

class Overridor
  def self.new
    p 'made somet new'
    super
  end
  def initialize
    p 'initial eyes'
  end
end

Overridor.new
