require './robot.rb'

def get_function( num )
  puts "Enter function #{num}: (fwd, rc, ra)"
  command_string = gets.chomp
  command_string.split(/\,?\s+/)
end

f1 = get_function( 'one' );
puts f1.join( ',' );
puts f1.length

f2 = get_function( 'two' );
puts f2.join( ',' );

rob = Robot.new( f1, f2 )

while rob.status == :playing
  puts "Enter move: (fwd, rc, ra, f1, f2)"
  command = gets.chomp
  puts rob.move(command)
end

puts "Game end: #{rob.status}"
