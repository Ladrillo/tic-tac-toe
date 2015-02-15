require 'pry'

positions = {aa:' ', ab:' ', ac:' ', ba:' ', bb:' ', bc:' ', ca:' ', cb:' ', cc:' '}

def random_position(positions)
  [:aa, :ab, :ac, :ba, :bb, :bc, :ca, :cb, :cc].sample
end

def lines(positions) 
  {
    aa_ab_ac: [positions[:aa], positions[:ab], positions[:ac]], 
    ba_bb_bc: [positions[:ba], positions[:bb], positions[:bc]], 
    ca_cb_cc: [positions[:ca], positions[:cb], positions[:cc]], 
    aa_ba_ca: [positions[:aa], positions[:ba], positions[:ca]], 
    ab_bb_cb: [positions[:ab], positions[:bb], positions[:cb]], 
    ac_bc_cc: [positions[:ac], positions[:bc], positions[:cc]], 
    aa_bb_cc: [positions[:aa], positions[:bb], positions[:cc]], 
    ac_bb_ca: [positions[:ac], positions[:bb], positions[:ca]]
  }
end

def line(positions, line_symbol)
  lines(positions)[line_symbol]
end

def display_grid(positions)
  puts "
      |     |
   #{positions[:ca]}  |  #{positions[:cb]}  |  #{positions[:cc]}
 _____|_____|_____
      |     |
   #{positions[:ba]}  |  #{positions[:bb]}  |  #{positions[:bc]}
 _____|_____|_____
      |     |
   #{positions[:aa]}  |  #{positions[:ab]}  |  #{positions[:ac]}
      |     |"
end

def display_grid_instructions
  puts "
      |     |
   #{7}  |  #{8}  |  #{9}
 _____|_____|_____
      |     |
   #{4}  |  #{5}  |  #{6}
 _____|_____|_____
      |     |
   #{1}  |  #{2}  |  #{3}
      |     |"
end

def position(positions, position_symbol)
  positions[position_symbol]
end

def set_position(positions, position_symbol, new_value)
  positions[position_symbol] = new_value
end

def is_position_blank?(positions, position_symbol)
  position(positions, position_symbol) == ' ' ? true : false
end

def is_line_blank?(positions, line_symbol)
  line(positions, line_symbol).select { |pos| pos == ' ' }.size == 3 ? true : false
end

def is_line_full?(positions, line_symbol)
  line(positions, line_symbol).select { |pos| pos != ' ' }.size == 3 ? true : false
end

def is_grid_full?(positions)
  if positions.select { |pos, val| val == ' ' } == {} then true else false end
end

def is_line_in_danger?(positions, line_symbol, x_or_o)
  if is_line_full?(positions, line_symbol) == false && 
    line(positions, line_symbol).select { |pos| pos == x_or_o }.size == 2
    true
  else
    false
  end
end

def lines_in_danger(positions, x_or_o)
  lines(positions).select { |lin, val| is_line_in_danger?(positions, lin, x_or_o) }
end
      
def is_game_over?(positions)
  if lines(positions).select { |lin, val| val == ['X', 'X', 'X'] } != {} || 
    lines(positions).select { |lin, val| val == ['O', 'O', 'O'] } != {}
    true
  else 
    false
  end
end

def who_won_game(positions)
  if lines(positions).select { |lin, val| val == ['O', 'O', 'O'] } != {} then 'Computer' else 'Player' end
end

def lines_that_cross_position(positions, position_symbol)
  lines(positions).select { |lin, val| lin.to_s.include?(position_symbol.to_s) }
end  

def clean_lines_that_cross(positions, position_symbol)
  all_lines_that_cross = lines_that_cross_position(positions, position_symbol)
  all_lines_that_cross.select { |lin, val| val.include?('O') == false }
end

def translate_user_input(input)
  case input.to_i 
  when 1 then :aa
  when 2 then :ab
  when 3 then :ac
  when 4 then :ba
  when 5 then :bb
  when 6 then :bc
  when 7 then :ca
  when 8 then :cb
  when 9 then :cc
  else 'Invalid input'
  end
end

def user_plays(positions)
  begin
    puts 'Please choose an empty space using numbers from 1 to 9'
    user_input = gets.chomp
    user_choice = translate_user_input(user_input)
  end until user_choice != 'Invalid input' && is_position_blank?(positions, user_choice)
  set_position(positions, user_choice, 'X')
  display_grid(positions)
end

def computer_plays(positions)
  if lines_in_danger(positions, 'O') != {}  
    lines_in_danger(positions, 'O').first[1].select { |pos| pos == ' ' }[0].gsub!(/ /, 'O')
  elsif lines_in_danger(positions, 'X') != {}
    lines_in_danger(positions, 'X').first[1].select { |pos| pos == ' ' }[0].gsub!(/ /, 'O')   
  elsif is_position_blank?(positions, :bb)
    then set_position(positions, :bb, 'O')
  else
    begin
      play = random_position(positions)
    end until if is_position_blank?(positions, play) then set_position(positions, play, 'O') end
  end
  display_grid(positions)
end

def user_begins_game?
  choices = ['y', 'n']
  begin 
    puts "Do you want to make the first move? (Y/N)"
    user_choice = gets.chomp.downcase
  end until choices.include?(user_choice)
  user_choice == 'y' ? true : false
end

def game(positions)
  puts "Welcome to Gabriel's Tic-Tac-Toe!"  
  puts "Use your keyboard to play:"
  display_grid_instructions
  loop do    
    user_begins = user_begins_game?
    if user_begins
      loop do 
        user_plays(positions)
        break if is_game_over?(positions) || is_grid_full?(positions)
        computer_plays(positions)
        break if is_game_over?(positions) || is_grid_full?(positions)
      end  
    else
      loop do
        computer_plays(positions)
        break if is_game_over?(positions) || is_grid_full?(positions)
        user_plays(positions)
        break if is_game_over?(positions) || is_grid_full?(positions)
      end
    end
    puts 'Game Over!'
    puts "Do you want to play again? (Y/N)"
    play_again = gets.chomp.downcase
    positions = {aa:' ', ab:' ', ac:' ', ba:' ', bb:' ', bc:' ', ca:' ', cb:' ', cc:' '}
    break if play_again != 'y'
  end
end

puts "\n" * 25
game(positions)

# binding.pry  