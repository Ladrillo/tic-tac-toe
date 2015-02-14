require 'pry'

aa, ab, ac, ba, bb, bc, ca, cb, cc = ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '

# positions = {aa:aa, ab:ab, ac:ac, ba:ba, bb:bb, bc:bc, ca:ca, cb:cb, cc:cc}

lines = [
[aa, ab, ac],
[ba, bb, bc],
[ca, cb, cc],
[aa, ba, ca],
[ab, bb, cb],
[ac, bc, cc],
[aa, bb, cc],
[ac, bb, ca]
]

lines_with_names = [
[:aa, :ab, :ac],
[:ba, :bb, :bc],
[:ca, :cb, :cc],
[:aa, :ba, :ca],
[:ab, :bb, :cb],
[:ac, :bc, :cc],
[:aa, :bb, :cc],
[:ac, :bb, :ca]
]

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


grid_after_player_move = -> number do 
    if number == 1 then aa.gsub!(/ /,'X')
      elsif number == 2 then ab.gsub!(/ /,'X')
      elsif number == 3 then ac.gsub!(/ /,'X')
      elsif number == 4 then ba.gsub!(/ /,'X')
      elsif number == 5 then bb.gsub!(/ /,'X')
      elsif number == 6 then bc.gsub!(/ /,'X')
      elsif number == 7 then ca.gsub!(/ /,'X')
      elsif number == 8 then cb.gsub!(/ /,'X')
      elsif number == 9 then cc.gsub!(/ /,'X')
    end
end


def x_count(line) line.count('X') end
def o_count(line) line.count('O') end


def lines_in_red_alert(lines)
  lines.select { |line| x_count(line) == 2 }
end


def defensive_play(lines)
  if lines_in_red_alert(lines).first
    play_line(lines_in_red_alert(lines).sample)
  end
end


def play_line(line)
  free_positions = line.select { |position| position == ' ' }
  free_positions.sample.gsub!(/ /, 'O')
end

def number_of_clean_lines_for_a_position(position, lines) 
  lines_that_intersect = lines_with_names.select { |lin| lin.include?(position) }
  clean_lines_that_intersect = lines_that_intersect.select { |lin| lin.select { |pos| positions[pos] != 'X' } } 
  puts clean_lines_that_intersect
end


def lines_that_intersect_position(position, lines)



def positions
  {aa:aa, ab:ab, ac:ac, ba:ba, bb:bb, bc:bc, ca:ca, cb:cb, cc:cc}
end

lines = [
[aa, ab, ac],
[ba, bb, bc],
[ca, cb, cc],
[aa, ba, ca],
[ab, bb, cb],
[ac, bc, cc],
[aa, bb, cc],
[ac, bb, ca]
]

def lines_with_names
  [
    [:aa, :ab, :ac],
    [:ba, :bb, :bc],
    [:ca, :cb, :cc],
    [:aa, :ba, :ca],
    [:ab, :bb, :cb],
    [:ac, :bc, :cc],
    [:aa, :bb, :cc],
    [:ac, :bb, :ca]
  ]
end

puts display_grid.call
grid_after_player_move.call(1)
grid_after_player_move.call(5)
puts display_grid.call

defensive_play(lines)
puts display_grid.call

number_of_clean_lines_for_a_position(:ac, lines)