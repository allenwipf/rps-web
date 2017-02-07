require "pry"

# Check to see if a player has a score of 3 and returns winner annoucement
#
# p1_score - int total score of player 1
# p2_score - int total score of player 2
#
# Examples
# 	the_winner(3, 0)
# 	# => "Game over! Player 1 wins!"
# 
# Returns winner annoucement String related to who won
def the_winner(p1_score, p2_score)
	if p1_score >= 3	
		return "Game over! Player 1 wins!"	
	elsif p2_score >= 3
		return "Game over! Player 2 wins!"	
	end
end

# Check to see if the input a player gave was either rock, paper or scissors.
#
# answer - player input on website
#
# Examples
# 	quality_control("dog")
# 	# => false
#   
#   quality_control("rock")
#   # => true
# 
# Returns either true of false
def quality_control(answer)
	if answer == "cheat code"
		session["p1_total_score"] = 100 - 1 
		return true
	elsif answer == "rock" or answer == "scissors" or answer == "paper"
		return true
	else
		return false
	end	
end

# Check to see who the winner is related to the input from 2 players
#
# p1_answer - player1's input
# p1_answer - player2's input
#
# Examples
# 	round_win("rock", "paper")
# 	# => "Player 2 wins this round!"
#   
#   round_win("paper", "rock")
#   # => "Player 1 wins this round!"
# 
# Returns a Integer of which player won. Returns 0 if a tie.
def round_win(p1_answer, p2_answer)
	if p1_answer == p2_answer
		return 0
	elsif p1_answer == "rock" and p2_answer == "paper"
		return 2
	elsif p1_answer == "scissors" and p2_answer == "rock"
		return 2
	elsif p1_answer == "paper" and p2_answer == "scissors"
	 	return 2
	else
		return 1
	end
end

def round_win_message(winner)
	if winner == 1
		return "Player 1 wins this round!"
	elsif winner == 2
		return "Player 2 wins this round!"
	else
		return "It's a tie! Try again!"
	end
end

# Takes round_win function return and increments the score of 
# the related player
#
# winner - a string that announces the round winner
#
# Examples
# 	tally_score("Player 1 wins this round")
# 	# => Player1's score will be incremented by 1
# 
# There is no return
def tally_score(winner)
	(session["p#{winner}_total_score"] += 1) unless (winner == 0)
end 






