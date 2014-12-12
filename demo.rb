require './robot.rb'

rob = Robot.new( %w[fwd fwd rc fwd], %w[rc rc fwd rc] )

puts rob.move('fwd')
puts rob.move('fwd')
puts rob.move('ra')
puts rob.move('fwd')
puts rob.move('fwd')
puts rob.move('f2')
puts rob.move('f1')
puts rob.move('f1')
puts rob.move('fwd')

puts "Game end: #{rob.status}"
