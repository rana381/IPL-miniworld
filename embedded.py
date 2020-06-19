import mysql.connector
from mysql.connector import Error
import time
import datetime

#config for database
user_name = ""
password = ""
host_addr = ""
DB_name = "ipl3"

config = {
  'user': "root",
  'password': "password",
  'host': "localhost",
  'database': DB_name,
}

def create_connection():
	connection = None
	try:
		connection = mysql.connector.connect(**config)
		print("Connection to MySQL DB successful")
	except Error as e:
		print(f"The error '{e}' occurred")

	return connection

def close_connection(c):
	if(c != None):
		c.close()

def query(connection, query):
	cursor = connection.cursor(dictionary=True)
	try:
		cursor.execute(query)
		connection.commit()
	except Error as e:
		print(f"The error '{e}' occurred")

def execute_read_query(connection, query):
    cursor = connection.cursor(dictionary=True)
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as e:
        print(f"The error '{e}' occurred")


def query_mysql(query):
	cnx = mysql.connector.connect(user='myusername', password='mypass',
								  host='myip',port='myport',
								  database='dwh',charset="utf8", use_unicode = True)
	cursor = cnx.cursor()
	cursor.execute(query)
	#get header and rows
	header = [i[0] for i in cursor.description]
	rows = [list(i) for i in cursor.fetchall()]
	#append header to rows
	rows.insert(0,header)
	cursor.close()
	cnx.close()
	return rows

def get_table_columns(connection,table_name):
	cursor = connection.cursor(dictionary=False)
	result = None
	try:
		cursor.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME =\"" + table_name + "\" and TABLE_SCHEMA=\'"+(DB_name)+"\'")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

# *************** SELECT COMMANDS ***************

####################################################################################################################################################

### TEAMS ###

def get_teams(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from Team")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_top_teams_points(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT team_name, matches_won, matches_lost, points_tournament from Team ORDER BY points_tournament DESC LIMIT 4")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_top_teams_fairplay(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT team_name, matches_won, matches_lost, points_fairplay from Team ORDER BY points_fairplay DESC LIMIT 4")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_team_points(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT team_name, points_tournament from Team WHERE team_name=\"" + team_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_captain_of_team(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("select player_name from Player where(player_id) in (select captain_id from Team where team_name=\"" + team_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_sponsors_of_team(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT sponsor_name from Sponsors WHERE team_id in (SELECT team_id from Team WHERE team_name=\"" + team_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


def get_team_with_draw(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT team_name, matches_draw from Team WHERE matches_draw >= 1")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_teans_with_Orange_Purple_cap(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute(" SELECT team_name from Team T INNER JOIN ((SELECT team_id from Player ORDER BY total_wickets DESC LIMIT 1) UNION (SELECT team_id from Player ORDER BY total_runs DESC LIMIT 1)) Temp WHERE T.team_id = Temp.team_id")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

#######################################################################################################################################################

### MANAGERS ###
def get_managers(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from Coach")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_coach_data(connection, coach_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * FROM Coach WHERE Coach_name=\"" + coach_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_coach_of_team(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * FROM Coach WHERE team_id in (SELECT team_id FROM Team WHERE team_name=\"" + team_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


####################################################### UPDATE QUERY GOES HERE ###########################################333







##################################################################################################################################################3

### OWNERS ###

def get_owners(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from Owners")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_owner_of_team(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * FROM Owners WHERE team_name=\"" + team_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_most_exp_by_owner(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT owner_name FROM Owners O, (SELECT bought_by FROM Auction ORDER BY sold_for DESC LIMIT 1) B WHERE O.team_name = B.bought_by")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_owner_team_details(connection, owner_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT owner_name, O.team_name , matches_won,matches_lost,points_tournament FROM Owners O INNER JOIN team T WHERE owner_name=\"" + owner_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_owner_money_spent(connection, owner_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT owner_name, sum(sold_for) FROM (Auction A NATURAL JOIN (SELECT owner_name, team_name as bought_by FROM Owners) O) WHERE owner_name=\"" + owner_name + "\")) GROUP BY owner_name")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")



###########################################################################################################################################################

### Grounds ###
def get_cricketGround(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * FROM CricketGrounds")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_homeground_of_team(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("select Ground_name from CricketGrounds where homeground_for =\"" + team_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_ground_for_match(connection, team1, team2):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("select Ground_name from CricketGrounds where ground_id in (select stadium_id from Matches where team1=\"" + team1 + "\" and team2=\"" + team2 + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


def get_cricketGround_data(connection, ground_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * FROM CricketGrounds WHERE Ground_name=\"" + ground_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_no_of_matches_in_ground(connection, ground_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT Ground_name, count(*) as 'No of Matches' FROM ( (SELECT Ground_name, ground_id as stadium_id FROM cricketgrounds) as Gngi NATURAL JOIN Matches) WHERE Ground_name=\"" + ground_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


################################  ADD insert Query Here #########################################3


######################################################################################################################################

### Player Board ###
def get_players(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from Player")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_top_run_scorers(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name, team_name, total_runs from Player ORDER BY total_runs DESC LIMIT 3")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_top_wicket_takers(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name, team_name, total_wickets from Player ORDER BY total_wickets DESC LIMIT 3")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_most_expensive_players(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name, sold_for, bought_by from Auction ORDER BY sold_for DESC LIMIT 3;")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_team_players(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name, date_joined, total_runs, total_wickets from Player WHERE team_name=\"" + team_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_player_data(connetion, player_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from Player WHERE player_name=\"" + player_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


#############################################   add insert/ update queries here ###########################################


########################################################################################################################################

### Player ###

def get_purple_cap(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from Player ORDER BY total_wickets DESC LIMIT 1")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_orange_cap(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from Player ORDER BY total_runs DESC LIMIT 1")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_indian_players(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name from Player WHERE team_name=\"" + team_name + "\" and nationality='Indian'")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_foreign_players(connection, team_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name from Player WHERE team_name=\"" + team_name + "\" and nationality NOT LIKE 'Indian'")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_owner_details_for_players(connection, player_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT owner_name from (Player NATURAL JOIN Owners) WHERE player_name=\"" + player_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_sponsor_details_for_players(connection, player_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT sponsor_name from (Player NATURAL JOIN sponsors) WHERE player_name=\"" + player_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

#########################################################################################################################################

### Officials ###

def get_officials(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * FROM Officials")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_officials_of_match(connection, match_no):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT official_name FROM (Officials NATURAL JOIN (SELECT * FROM officialsformatch WHERE match_no=" + match_no + ") Off )")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_officials_data(connection, official_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * FROM Officials WHERE official_name=\"" + official_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_officials_matches(connection, official_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT official_name, match_no FROM (Officials NATURAL JOIN (SELECT * FROM officialsformatch) Off) WHERE official_name=\"" + official_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")



##########################################################################################################################################################

### Sponsor ###

def get_sponsors(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from sponsors")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_teams_sponsored_by(connection, sponsor_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("select team_name from Team where(team_id) in (select team_id from Sponsors where sponsor_name=\"" + sponsor_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


def get_performance_teams_sponsored_by(connection, sponsor_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("Select matches_won, matches_lost, matches_draw, points_tournament, points_fairplay From team t, sponsors s Where t.team_id = s.team_id and s.sponsors_name =\"" + sponsor_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_performance_players_sponsored_by(connection, sponsor_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("Select total_runs, total_wickets From players p, sponsors s Where p.team_id = s.sponsors_id and s.sponsors_name =\"" + sponsor_name + "\")")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")



#######################################################################################################################################################

### Broadcasters ###
def get_broadcasters(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from BroadcastChannel")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


def get_commentators_of_match(connection, match_no):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT commentator_name FROM (commentators NATURAL JOIN commentatorsformatches CM) WHERE CM.match_id="+ str(match_no))
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_commentators(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT commentator_name from commentators")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


#################################################################################################################################################

### Auction Committee ###

def get_total_teams(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT count(*) from Team")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_auction(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from auction")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_base_price_for_players(connection, player_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name,initial_bid, sold_for from auction WHERE player_name=\"" + player_name + "\"")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_unsold_players(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player.* FROM player LEFT JOIN auction ON (player.player_id = auction.player_id) WHERE auction.player_id IS NULL")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


#################################################################################################################################################

def add_data(connection, dic, table_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	data = list(dic.values())
	col = list(dic.keys())
	command = "INSERT INTO "+ table_name + "(" + col[0]
	for x in col[1:]:
		command = command + "," + x 
	command = command + ")"

	command += " VALUES (" + "\'" + data[0] + "\'"
	for x in data[1:]:
		command = command + "," + "\'" + x + "\'"
	command = command + ")"

	try:
		cursor.execute(command)
		connection.commit()
		print("Executed Succesfully")
	except Error as e:
		print(f"The error '{e}' occurred")


def update_data(connection, dic, table_name,lis,id_for):
	cursor = connection.cursor(dictionary=True)
	result = None
	data = list(dic.values())
	col = list(dic.keys())
	command = "UPDATE "+ table_name + " SET " + col[0] + " = " + data[0]
	for x in range(len(col[1:])):
		command = command + "," + col[x] + " = " + data[x] 
	
	command += " WHERE " + lis + " = " + str(id_for)
	try:
		print(command)
		cursor.execute(command)
		connection.commit()
		print("Executed Succesfully")
	except Error as e:
		print(f"The error '{e}' occurred")


def delete_data(connection, dic, table_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	data = list(dic.values())
	col = list(dic.keys())
	command = "DELETE FROM "+ table_name + " WHERE "
	temp = ""
	for i in range(len(data)):
		temp = col[i] + " = " + data[i]

	command += temp

	print(command)

	try:
		cursor.execute(command)
		connection.commit()
		print("Executed Succesfully")
	except Error as e:
		print(f"The error '{e}' occurred")


def get_table(connection, table_name):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT * from " + table_name)
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_rollup(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT Nationality, team_name,SUM(total_runs) 'Runs' ,SUM(total_wickets) 'Wicket' FROM player GROUP BY Nationality,team_name WITH ROLLUP")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_highest_bid_team(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT bought_by 'Team', player_name,sold_for, RANK() OVER (PARTITION BY bought_by ORDER BY sold_for DESC ) 'Highest_Purchase' FROM auction")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")

def get_avg_stats_team(connection):
	cursor = connection.cursor(dictionary=True)
	result = None
	try:
		cursor.execute("SELECT player_name, team_name, total_runs, AVG(total_runs) OVER(PARTITION BY team_name) as average_runs_of_team, total_wickets, AVG(total_wickets) OVER(PARTITION BY team_name) as average_wickets_of_team from player")
		result = cursor.fetchall()
		return result
	except Error as e:
		print(f"The error '{e}' occurred")


# ***********************
# 	FUNCTIONS END
# ***********************

# # #create connection to database
# connection = create_connection()

# t = "owners"

# teamData = get_table_columns(connection,t)

# # for i in teamData:
# # 	print(list(i.values()))

# print(teamData[0][0])

# connection.close()
