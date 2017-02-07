require "sinatra"
require "pry"
require_relative './functions.rb'
enable :sessions

# Calls different functions to see who won the round, tallys the appropriate scores
# and to declares an overall winner if max store set by function is reached. 
#
# Functions Called
# 	round_win(p1_answer, p2_answer)
# 	tally_score(winner) 
# 	the_winner(p1_score, p2_score)
# 
# Please see fuctions page to see description of each of these fuctions
#
# There is no Return for this function
def process_picks()
	session["round_winner"] = round_win(session["p1_pick"], session["p2_pick"])
    tally_score(session["round_winner"])
    session["game_winner"] = the_winner(session["p1_total_score"], session["p2_total_score"])
end

# Post Controller Clears and Sets different Session vars and resets the game
post("/start"){ 
	session.clear
	session["p1_picked"] = "No"
	session["show_p1_box"] = "Yes"
	session["p1_total_score"] = 0
	session["p2_total_score"] = 0
	erb :play
	redirect "/"  
}

# Gets loads the page each time it's refreshed according to vars set by post("/start") and post("/")
get ("/"){

	@round_winner = session["round_winner"]
	session.delete("round_winner")
	session["p1_total_score"]
	session["p2_total_score"]
	@current_score = session["game_winner"]

	erb :play
}

# Sets the varialbes used by get("/"). The if statement sets variables for get("/") to show and hide specific 
# boxes depending on game progression. Calls quality_control function to check if player input is allowed.
post ("/") {
		
    if (session["show_p1_box"] != "Yes") then

		if quality_control(params[:p2_pick])
			session["p2_pick"] = params[:p2_pick]
			session["show_p1_box"] = "Yes"
	    else 
	    	session["p2_pick"] = "try_again"
	    	redirect "/"
	    end

    elsif quality_control(params[:p1_pick])
		session["p1_pick"] = params[:p1_pick]
		session["show_p1_box"] = "No"
		redirect "/"
	else          
		session["p1_pick"] = "try_again" 
    	redirect "/" 		
    end
    
  	process_picks()
    redirect "/"  
}





