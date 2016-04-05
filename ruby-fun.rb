#!ruby

# http://www.troubleshooters.com/codecorn/ruby/basictutorial.htm#_About
# https://rubymonk.com/
# https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/18-blocks/lessons/64-blocks-procs-lambdas

puts "\ntriple elipse non-inclusive"
for ss in 1...3
	print ss, " Hello\n";
end

puts "\ndouble elipse inclusive"
for ss in 3..6
	print ss, " Goodbye\n";
end

puts "\narray iterate";
presidents = ["Reagan", "Bush1", "Clinton", "Bush2"]
for ss in 0...presidents.length
	print ss, ": ", presidents[ss], "\n";
end

puts "\nnegative array iterate, note loops always increase";
for ss in 1..presidents.length
	print -ss, ": ", presidents[-ss], "\n";
end

puts "\neach construct, block var in pipes, block in curly braces";
puts presidents.collect {|p| p.upcase}

puts "\ncollect construct, block var in pipes, block in curly braces";
puts presidents.collect {|p| p.upcase}

puts "\nwhile loop";
ss = 5
while (ss > 0)
  print ss, " "
  ss -= 1;
end
puts

puts "\n literal loop"
count = 5
count.times do
  print "fred "
end
puts

puts "\ncommand line args, trailing ifs";
if ( ARGV[0] == nil )
  puts "No cmd line args";
else
  puts "one arg:", ARGV if ARGV.length == 1
  puts "multi args:", ARGV if ARGV.length > 1
end

puts "\n pop last and put at front"
puts presidents.unshift presidents.pop

puts "\n return front element to tail"
puts presidents.push presidents.shift

puts "\n array slice range"
puts presidents[1..2]

puts "\n array slice start + count"
puts presidents[1,2]

puts "\n Hash (i.e. Map)"
hash = {"key1"=>"val1", "key2"=>"val2"}
print "hash:", hash, "\n"
puts hash["key1"]

puts "\n regex"
string1 = "I will drill for a well in walla walla washington."
if string1 =~ /(w.ll)/
	print "Matched on ", $1, "\n"
else
	puts "NO MATCH"
end

string1 = "I will drill for a well in walla walla washington."
regex = Regexp.new(/w.ll/)
matchdata = regex.match(string1)
if matchdata
	puts matchdata[0]
else
	puts "NO MATCH"
end

puts "\n error handling, file I/O"
begin
	input = File.new("./ruby-test.txt", "r")
rescue 
	print "Failed to open ./ruby-test.txt for input. ", $!, "\n"
end	
input.each { |line|
	puts line;
	}
input.close()

puts "\n subhash via predicate"
h = {"key1"=>"val1", "key2"=>"val2"}.select {|k,v| v.include?("2")}
puts h

puts "\n raise error, retry"
val = 10;
begin
	raise RangeError, "Bogus!", caller if val < 20
	print "yay! ", val, "\n"
rescue  RangeError => e
        puts e
	val = 100
	retry
end


puts "/n simple class"
class Total
	def initialize(initial_amount)
		@total=initial_amount
	end

	def increaseBy(increase)
		@total += increase
	end

	def multiplyBy(increase)
		@total *= increase
	end

	def setTo(amount)
		@total = amount
	end

	def getTotal() return @total; end
	def hasTotal() return @total!=nil; end
end

total = Total.new(0)
print total.class, "\n"

for ss in 1..4
	total.increaseBy(ss)	
	puts total.getTotal if total.hasTotal
end
print "Final total: ", total.getTotal, "\n" if total.hasTotal


puts "\n getters/setters"
class Person
	def initialize(lname, fname)
		@lname = lname
		@fname = fname
	end

	def lname
		return @lname
	end

	def lname=(myarg)
		@lname = myarg
	end

        # getter/setter shorthand
	attr_reader :fname
	attr_writer :fname
end

person = Person.new("Shaughnessy", "Jay")
print "My name is ", person.fname, " ", person.lname, ".\n"
person.fname = "Jayb0"
print "My name is ", person.fname, " ", person.lname, ".\n"

class Person
	def initialize(lname, fname)
		@lname = lname
		@fname = fname
	end

	attr_reader :lname, :fname
	attr_writer :lname, :fname
end

puts "\n Inheritance"
class Employee < Person               # Declare Person to be parent of Employee
	def initialize(lname, fname, empno)
		super(lname, fname)   # Initialize Parent's (Person) data
		                      #   by calling Parent's initialize()
		@empno = empno        # Initialize Employee specific data

	end
	attr_reader :empno            # Accessor for employee specific data
	attr_writer :empno            # Accessor for employee specific data
	                              # Parent's data already given accessors
				      # by parent class definition
end

person = Employee.new("Shaughnessy", "Jay", "583499")
print person.fname, " ", person.lname, " is employee number ", person.empno, ".\n"

puts "\n Operator creation, self, += for free"
class Total
	def getTotal() return @total; end
	def hasTotal() return @total!=nil; end
	def initialize(initial_amount)
		@total=initial_amount
	end

	def increaseBy(b)
		@total += b
	end

	def add(b)
		if b.class == Total
			return Total.new(@total + b.getTotal())

		else
			return Total.new(@total + b)
		end
	end

	def +(b)
		self.add(b)
	end

	def *(b)
		if b.class == Total
			return Total.new(@total * b.getTotal())

		else
			return Total.new(@total * b)
		end
	end
end

total5 = Total.new(5)
total2 = Total.new(2)
total3 = Total.new(3)

myTotal = total5 + total2 + total3
print myTotal.getTotal(), "\n"

myTotal *= 2
print myTotal.getTotal, "\n"

myTotal += 10
print myTotal.getTotal, "\n"

# default self is main
puts "\n", self

# no arg methods don't need parens, methods can be chanined
puts "\n", 1.next.next

puts "\n", 1.methods.sort
puts "\n", 1.between?(0,2)

#puts "\n", 1.instance_methods.sort

puts "\n", "String token replacement, single-quotes no ecapes"
token = "foo"
puts "#{token} bar baz"
puts '#{token} bar baz'

puts "\n", "Object equality and =="
s1 = 'Foo'
s2 = 'Foo'
puts "s1 == s2       #{s1 == s2}"
puts "s1.equal? s2   #{s1.equal? s2}"
puts "s1.equal? s1   #{s1.equal? s1}"
puts "s1.eql?( s2 )  #{s1.eql? s2}"
puts "'F' == 'F'     #{'F' == 'F'}"
puts "'F'.equal? 'F' #{'F'.equal? 'F'}"
puts "'F'.eql? 'F'   #{'F'.eql? 'F'}"

puts "\n", "Class with spaceship defined"
class Sock
  include Comparable
  attr_reader :size
  def initialize size
    @size = size
  end

  def <=>(another_sock)
    if self.size < another_sock.size
      -1
    elsif self.size > another_sock.size
      1
    else
      0
    end
  end
end
sock1 = Sock.new(10)
sock2 = Sock.new(11)
sock3 = Sock.new(10)
puts "Are sock1 and sock3 equal? #{sock1 == sock3}"
puts "Are sock1 and sock2 NOT equal? #{sock1 != sock2}"
puts "Is sock1 > sock3? #{sock1 > sock3}"
puts "Is sock1 < sock2? #{sock1 < sock2}"
puts "Is sock1 >= sock3? #{sock1 >= sock3}"
puts "Is sock1 <= sock2? #{sock1 <= sock2}"

puts "\nArray stuff"
nums = [1,2,3,4,5]
nums.each {|n|
  print n.to_s<<" "
}
puts
print nums, " map *5 ", nums.map {|n| n * 5}
puts
print nums, " select odd ", nums.select {|n| n % 2  == 1}
puts
temp = nums.clone
temp.delete 3
print nums, " delete 3 ", temp
puts
# Note, right to left eval means we need to do this to see the original array
temp = nums.clone
print temp, " delete even ", nums.delete_if {|n| n % 2  == 0}
puts

puts
print "a"
puts
puts  "a"
puts
p     "a"
puts

puts 1.is_a?(Integer)
puts 1.is_a?(String)

puts
print "nil: #{nil}\n"
p     nil

puts "variable args, trailing hash"
def calculate(*args)
  options = args[-1].is_a?(Hash) ? args.pop : {}
  return add(*args) if options.empty? || options[:add]
  return subtract(*args)
end
def add(*numbers)
  numbers.inject(0) {|sum,n| sum+n}
end
def subtract(*numbers)
  first = numbers[0]
  numbers.drop(1).inject(first) {|sum,n| sum-n}
end
puts calculate(-10, 2, 3, add: true) # returns -5
puts calculate(-10, 2, 3, subtract: true) #returns -15 ?

puts "OOB IO Streams"
io_streams = Array.new
ObjectSpace.each_object(IO) { |x| io_streams << x }
puts io_streams

puts
puts Fixnum.methods.sort

puts
puts "\n iterative/recusive ancestry check"
def is_ancestor?(klass, subclass)
  current_class = subclass
  while !current_class.superclass.nil? && current_class != klass
    current_class = current_class.superclass
  end
  current_class == klass
end

def is_ancestor?(klass, subclass)
  return false if subclass == nil
  return true if subclass.superclass == klass
  is_ancestor?(klass, subclass.superclass)
end


puts
puts "\n self (static) methods"
class Foo
  @@message = "Foo Is Dumbest!"
  
  def self.dumb
    puts "#{@@message}"
  end
end
Foo.dumb

puts "\n ==, eql?, hash"
class Item
  attr_reader :item_name, :quantity, :supplier_name, :price
  
  def initialize(item_name, quantity, supplier_name, price)
    @item_name = item_name
    @quantity = quantity
    @supplier_name = supplier_name
    @price = price
  end 
  
  # implement ==, eql? and hash
  def ==(other)
    @item_name == other.item_name &&
    @quantity == other.quantity &&
    @supplier_name == other.supplier_name &&
    @price == other.price
  end
  
  def eql?(other)
    self.==(other)
  end
  
  def hash
    @item_name.hash ^ @quantity.hash ^ @supplier_name.hash ^ @price.hash
  end
end

def test( arg: 5)
  puts arg
end

test
test arg: 10

p Time.at("1457707582999".to_i / 1000)
p Time.at("1457707582999".to_i / 1000).localtime
p Time.at("1457707582999".to_i / 1000).utc

puts "\t good bye yellow brick road \r\n".strip.gsub(/\s+/, "_")

