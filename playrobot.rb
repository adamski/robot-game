require './robot.rb'

def get_function( num )
  puts "Enter function #{num}: (fwd, rc, ra)"
  command_string = gets.chomp
  command_string.split(/\,?\s+/)
end

status = :playing

f1 = get_function( 'one' );
puts f1.join( ',' );

f2 = get_function( 'two' );
puts f2.join( ',' );

rob = Robot.new( f1, f2 )

while status == :playing
  puts "Enter move: (fwd, rc, ra, f1, f2)"
  command = gets.chomp
  puts rob.move(command)
  status = rob.status
end

puts 'Game end: '+status
