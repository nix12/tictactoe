require_relative 'player.rb'

class Game
	attr_accessor :board
	def initialize
		@board = "1|2|3\n4|5|6\n7|8|9"
		puts 'Please enter first player name'
		@player1 = Player.new(gets.chomp)
		puts 'Please enter second player name'
		@player2 = Player.new(gets.chomp)
		@winning_combinations = [['1','2','3'],['4','5','6'],['7','8','9'],['1','5','9'],
								['3','5','7'], ['1','4','7'],['2','5','8'],['3','6','9']]
		@tray1 = []
		@tray2 = []
		@turn = 1
		puts board
	end
		
    def place_x(number)
	    number = number.to_s
        board.gsub!(number, "x")
		puts board
    end

	def place_o(number)
		number = number.to_s
		board.gsub!(number, "o")
		puts board
	end
	
	def start
		if @turn.odd? && @turn < 10
			@turn += 1
			puts "Player #{@player1.name}'s turn"
			number = gets.chomp
			@tray1 << number
			place_x(number)
			check_for_win(@tray1, @player1)
			next_turn
		elsif @turn.even? && @turn < 10
			@turn += 1
			puts "Player #{@player2.name}'s turn"
			number = gets.chomp
			@tray2 << number
			check_for_win(@tray2, @player2)
			place_o(number)
			next_turn
		else
			puts 'game end'
		end
	end

	def check_for_win(tray, player)
		tray.sort.combination(3).each do |pick|
			@winning_combinations.each do |combo|
				if pick == combo
					puts player.name + " wins"
					puts 'Would you like to play again?'
					puts 'y for new or n to quit'
					new_game = gets.chomp
					if new_game.to_s == 'n'
						exit
					else
						Game.new.start
					end
				end
			end
		end
	end

	def next_turn
		start
	end
end

tictactoe = Game.new

tictactoe.start
