require 'pry'

grid = [[],[],[]]

aa, ab, ac, ba, bb, bc, ca, cb, cc = ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '

grid[0][0] = aa
grid[0][1] = ab
grid[0][2] = ac
grid[1][0] = ba
grid[1][1] = bb
grid[1][2] = bc
grid[2][0] = ca
grid[2][1] = cb
grid[2][2] = cc


display_grid = -> { "
      |     |
   #{ca}  |  #{cb}  |  #{cc}
 _____|_____|_____
      |     |
   #{ba}  |  #{bb}  |  #{bc}
 _____|_____|_____
      |     |
   #{aa}  |  #{ab}  |  #{ac}
      |     |" }

puts display_grid.call

grid_after_player_move = -> number do	
	  if number == 1 then aa.gsub!(/./,'X')
		  elsif number == 2 then ab.gsub!(/./,'X')
			elsif number == 3 then ac.gsub!(/./,'X')
			elsif number == 4 then ba.gsub!(/./,'X')
			elsif number == 5 then bb.gsub!(/./,'X')
			elsif number == 6 then bc.gsub!(/./,'X')
			elsif number == 7 then ca.gsub!(/./,'X')
			elsif number == 8 then cb.gsub!(/./,'X')
			elsif number == 9 then cc.gsub!(/./,'X')
		end
end
	
grid_after_computer_move = -> number do
	  if number == 1 then aa.gsub!(/./,'O')
		  elsif number == 2 then ab.gsub!(/./,'O')
			elsif number == 3 then ac.gsub!(/./,'O')
			elsif number == 4 then ba.gsub!(/./,'O')
			elsif number == 5 then bb.gsub!(/./,'O')
			elsif number == 6 then bc.gsub!(/./,'O')
			elsif number == 7 then ca.gsub!(/./,'O')
			elsif number == 8 then cb.gsub!(/./,'O')
			elsif number == 9 then cc.gsub!(/./,'O')
		end
end

grid_after_player_move.call(2)

puts display_grid.call

grid_after_computer_move.call(9)

puts display_grid.call
#binding.pry
p grid