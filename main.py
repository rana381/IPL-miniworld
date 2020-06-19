from flask import *
import random
import numpy as np
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, FieldList, FormField, RadioField, DateField, FloatField,IntegerField, TimeField
from wtforms.validators import DataRequired
from embedded import *

class admin(FlaskForm):
	choice = RadioField('Select Operation', choices=[('1','INSERT'),('2','UPDATE'),('3','DELETE')])
	db = RadioField('Select Database', choices=[('1','MATCHES'),('2','OfficialsForMatches'),('3','AUCTION'),('4','UMPIRES'),('5','PLAYERS'),('6','TEAMS'),('7','OWNERS'),('8','MANAGERS'),('9','GROUNDS'),('10','HOMEGROUND'),('11','SPONSORS'),('12','BROADCASTERS'),('13','COMMENTATORS'),('14',"COMMENTATORS FOR MATCH")])

class CricketGroundCommittee(FlaskForm):
	choice = RadioField('Select Operation', choices=[('1','INSERT'),('2','UPDATE'),('3','DELETE')])
	db = RadioField('Select Database', choices=[('9','GROUNDS'),('10','HOMEGROUND')])

class AuctionCommittee(FlaskForm):
	choice = RadioField('Select Operation', choices=[('1','INSERT'),('2','UPDATE'),('3','DELETE')])
	db = RadioField('Select Database', choices=[('3','AUCTION'),('5','PLAYERS'),('6','TEAMS')])

class PlayerBoard(FlaskForm):
	choice = RadioField('Select Operation', choices=[('1','INSERT'),('2','UPDATE'),('3','DELETE')])
	db = RadioField('Select Database', choices=[('5','PLAYERS')])

class Manager(FlaskForm):
	choice = RadioField('Select Operation', choices=[('1','INSERT'),('2','UPDATE'),('3','DELETE')])
	db = RadioField('Select Database', choices=[('6','TEAMS')])

class MATCHES_insert(FlaskForm):
	team1 = StringField('Team 1 Name.', validators=[DataRequired()])
	team2 = StringField('Team 2 Name', validators=[DataRequired()])
	stadium_id = IntegerField('Stadium id.', validators=[DataRequired()])
	date = DateField('Match Date', validators=[DataRequired()])
class OfficialsForMatches_insert(FlaskForm):
	match_no = IntegerField('Match No.', validators=[DataRequired()])
	official_id = IntegerField('Official id.', validators=[DataRequired()])
class AUCTION_insert(FlaskForm):
	player_id = IntegerField('Purchased Player id.', validators=[DataRequired()])
	player_name = StringField('Purchased Player Name.', validators=[DataRequired()])
	initial_bid = StringField('Initial Bid', validators=[DataRequired()])
	sold_for = FloatField('Sold For', validators=[DataRequired()])
	bought_by = StringField('bought by (Team Name.)', validators=[DataRequired()])
class UMPIRES_insert(FlaskForm):
	official_name = StringField('Name', validators=[DataRequired()])
	designation = StringField('Designation', validators=[DataRequired()])
	date_joined = DateField('Date Joined', validators=[DataRequired()])
	salary_per_match = FloatField('Salary', validators=[DataRequired()])
class PLAYERS_insert(FlaskForm):
	player_name = StringField('Name', validators=[DataRequired()])
	# date_joined = DateField('Date Joined', validators=[DataRequired()])
	salary_per_match = FloatField('Salary', validators=[DataRequired()])
	# team_name = StringField('Team Name.', validators=[DataRequired()])
	total_runs = IntegerField('Total Runs', validators=[DataRequired()])
	total_wickets = IntegerField('Total Wickets', validators=[DataRequired()])
	# team_id = IntegerField('Team id.', validators=[DataRequired()])
class TEAMS_insert(FlaskForm):
	team_name = StringField('Name', validators=[DataRequired()])
	no_of_players = IntegerField('Number of Players', validators=[DataRequired()])
	no_of_overseas_player = IntegerField('No of Overseas Players', validators=[DataRequired()])
	owner_id  = IntegerField('Owner id.', validators=[DataRequired()])
	captain_id = IntegerField('Captain id.', validators=[DataRequired()])
	matches_won = IntegerField('Matches Won', validators=[DataRequired()])
	matches_lost = IntegerField('Matches Lost', validators=[DataRequired()])
	matches_draw = IntegerField('Matches Drawn', validators=[DataRequired()])
	points_tournament = IntegerField('Total Points', validators=[DataRequired()])
	points_fairplay = IntegerField('Fairplay Points', validators=[DataRequired()])
class OWNERS_insert(FlaskForm):
	owner_name = StringField('Name', validators=[DataRequired()])
	# team_name = IntegerField('Team Name.', validators=[DataRequired()])
	ownership_stake = FloatField('Stake in Team', validators=[DataRequired()])
	# date_joined = DateField('Date Joined', validators=[DataRequired()])
class MANAGERS_insert(FlaskForm):
	coach_name = StringField('Name', validators=[DataRequired()])
	team_id = IntegerField('Team id.', validators=[DataRequired()])
	salary = FloatField('Salary', validators=[DataRequired()])
class GROUNDS_insert(FlaskForm):
	Ground_name = StringField('Name', validators=[DataRequired()])
	place = StringField('Place', validators=[DataRequired()])
class HOMEGROUND_insert(FlaskForm):
	team_id = IntegerField('Team id.', validators=[DataRequired()])
	ground_id = IntegerField('Ground id.', validators=[DataRequired()])
class SPONSORS_insert(FlaskForm):
	sponsor_name = StringField('Name', validators=[DataRequired()])
	team_id = IntegerField('Team id.', validators=[DataRequired()])
	sponsorship_scale = FloatField('Sponsorship Scale', validators=[DataRequired()])
class BROADCASTERS_insert(FlaskForm):
	channel_name = StringField('Name', validators=[DataRequired()])
class COMMENTATORS_insert(FlaskForm):
	commentator_name = StringField('Name', validators=[DataRequired()])
	available = BooleanField('Available', validators=[DataRequired()])
	current_channel = DateField('Channel Currently working for', validators=[DataRequired()])
class COMMENTATORSFORMATCH_insert(FlaskForm):
	match_id = IntegerField('Match No.', validators=[DataRequired()])
	chaneel_id = IntegerField('Channel No.', validators=[DataRequired()])
	commentator_id = IntegerField('Commentator Id.', validators=[DataRequired()])

class update_form(FlaskForm):
	id_for = StringField('id', validators=[DataRequired()])
	key = StringField('Changes', validators=[DataRequired()])

class delete_form(FlaskForm):
	id_for = StringField('id', validators=[DataRequired()])
	

########################################################################################################################
##GLOBAL VARIBLES
app = Flask(__name__)
app.config['SECRET_KEY'] = 'unique_key'
team = {}
team[0] =  "Official"
team[1] =  "Chennai Super Kings"
team[2] =  "Mumbai Indians"
team[3] =  "Delhi Capitals"
team[4] =  "Rajasthan Royals"
team[5] =  "Kings XI Punjab"
team[6] =  "Royal Challengers Bangalore"
team[7] =  "Sunriser Hyderabad"
team[8] =  "Kolkata Knight Riders"

rteam = {}
rteam["Guest"] =  0
rteam["CSK"] =  1
rteam["MI"] =  2
rteam["DC"] =  3
rteam["RR"] =  4
rteam["KXIP"] = 5
rteam["RCB"] =  6
rteam["SRH"] =  7
rteam["KKR"] =  8

Role = {}
Role["GUEST"] = 0
Role["MANAGER"] = 1
Role["OWNER"] = 2
Role["PLAYER BOARD"] = 3
Role["PLAYER"] = 4
Role["CRICKET GROUND COMMITTEE"] = 5
Role["AUCTION COMMITTEE"] = 6
Role["ADMIN"] = 7
Role["UMPIRE"] = 8
Role["SPONSOR"] = 9
Role["BROADCASTER"] = 10

Relation = {}
Relation[0] = 'matches'
Relation[1] = 'coach'
Relation[2] = 'owners'
Relation[3] = 'player'
Relation[4] = 'player'
Relation[5] = 'cricketgrounds'
Relation[6] = 'auction'
Relation[7] = 'teams'
Relation[8] = 'officials'
Relation[9] = 'sponsors'
Relation[10] = 'broadcastchannels'


modDB = [7,6,5,3,1]
Tables = {1:'Matches',2:'Officialsformatch',3:'Auction',4:'Officials',5:'Player',6:'Team',7:'Owners',8:'Coach',9:'Cricketgrounds',10:'Homeground',11:'Sponsors',12:'Broadcastchannel',13:'Commentators',14:'Commentatorsformatches'}

########################################################################################################################
## User classmethod(function)

class User(object):
	"""User Class- Encapsulates all attributes that a user has and are associated with them throughout the APP"""
	def __init__(self, nam,password,role,role_no,aff,t):
		super(User, self).__init__
		self.match_lost = 10 
		self.match_won = 30
		self.growth = "32%"
		self.tot_rev = "15,00,00,000"
		self.name = nam
		self.graph = "../static/Images/gr.png"
		self.role = role
		self.role_no = role_no
		self.t = t
		self.password = password
		self.Affliation = 3
		self.aff = aff
		self.joinedOn = "01/01/2000"
		self.table_on_dash1 = []
		self.table_on_dash2 = []

		self.performance_table0 = [["None"]]
		self.performance_table1 = []
		self.performance_table2 = []
		self.performance_table3 = []
		self.performance_table4 = []


##############################################################################################################################

def save(dictionary):
    np.save('my_file.npy', dictionary) 

def load():
    read_dictionary = np.load('my_file.npy',allow_pickle='TRUE').item()
    return read_dictionary

def setUser(name):
	cur_user = USERS[name]

def getData(t1):
	if t1 == None:
		return [[],[]]
	table1 = []
	head1 = []
	for i in t1:
		l1 =list(i.values())
		head1 = list(i.keys())
		l1 = [str(x) for x in l1]
		table1.append(l1)
	return [table1,head1]

def getTable(role,connection,t):

	r1 = None; r2 = None; r3 =None; r4 = None;
	if role == 1:
		h1 = "Managers"
		h2 = "Top Teams"
		h3 = "Team Players"
		h4 = "Captain"
		r1 = get_managers(connection)
		r2 = get_top_teams_points(connection)
		r3 = get_team_players(connection,t)
		r4 = get_captain_of_team(connection,t)
	elif role == 2:
		h1 = "Owners"
		h2 = "Top Teams"
		h3 = "Team Players"
		h4 = "Team Wise Highest Purchases"
		r1 = get_owners(connection)
		r2 = get_top_teams_points(connection)
		r3 = get_team_players(connection,t)
		r4 = get_highest_bid_team(connection,t)
		
	elif role == 3:
		h1 = "Top Run Scorer"
		h2 = "Top Wicket Takers"
		h3 = "Team Players"
		h4 = "Team Data"
		r1 = get_top_run_scorers(connection)
		r2 = get_top_wicket_takers(connection)
		r3 = get_team_players(connection,t)
		r4 = get_team_data(connection,t)

	elif role == 4:
		h1 = "Top Run Scorer"
		h2 = "Top Wicket Takers"
		h3 = "Team Players"
		h4 = "Captain of your Team"
		r1 = get_top_run_scorers(connection)
		r2 = get_top_wicket_takers(connection)
		r3 = get_team_players(connection,t)
		r4 = get_captain_of_team(connection,t)

	elif role == 6:
		h1 = "Total Teams"
		h2 = "Sales So Far"
		h3 = "Unsold Players"
		h4 = "You Are Not Allowed To View this Field"
		r1 = get_total_teams(connection)
		r2 = get_auction(connection)
		r3 = get_unsold_players(connection)

	elif role == 5:
		h1 = "Cricket Grounds"
		h2 = "You Are Not Allowed To View this Field"
		h3 = "You Are Not Allowed To View this Field"
		h4 = "You Are Not Allowed To View this Field"
		r1 = get_cricketGround(connection)

	elif role == 9:
		h1 = "Other Sponsors of Your Team"
		h2 = "Sponsors of All Teams"
		h3 = "Performance of Your Team"
		h4 = "Team Wise Highest Purchases"
		r1 = get_sponsors_of_team(connection,t)
		r2 = get_sponsors(connection)
		r3 = get_avg_stats_team(connection,t)
		r4 = get_team_data(connection,t)
		
	elif role == 8:
		h1 = "Umpires Currently Hired"
		h2 = "You Are Not Allowed To View this Field"
		h3 = "You Are Not Allowed To View this Field"
		h4 = "You Are Not Allowed To View this Field"
		r1 = get_officials(connection)

	elif role == 10:
		h1 = "All Broadcasters"
		h2 = "Sponsors for Advertisements"
		h3 = "You Are Not Allowed To View this Field"
		h4 = "You Are Not Allowed To View this Field"
		r1 = get_broadcasters(connection)
		r2 = get_sponsors(connection)
	else:
		h1 = "LeaderBoards"
		h2 = "Nationality-Team Wise Distribution of Runs and Wickets"
		h3 = "Avg Team Wise Stats of Players"
		h4 = "Team Wise Highest Purchases"
		r1 = get_top_teams_points(connection)
		r2 = get_rollup(connection)
		r3 = get_avg_stats_team(connection)
		r4 = get_highest_bid_team(connection)

	return [r1,r2,r3,r4,h1,h2,h3,h4]

def Serach(role,connection,t,val):
	r1 = None
	h1 = "No Suitable Results"
	if role == 1:
		if val.upper() == "MANAGER NAME":
			h1 = "Manager Information"
			r1 = get_coach_data(connection,t)
		elif val.upper() == "TEAM NAME":
			h1 = "Managers For Team " + str(t)
			r1 = get_coach_of_team(connection,t)

	elif role == 2:
		if val.upper() == "OWNER NAME":
			h1 = "Total Money Spent by "+ str(t)
			r1 = get_owner_money_spent(connection,t)
		elif val.upper() == "TEAM NAME":
			h1 = "Owner For Team " + str(t)
			r1 = get_owner_of_team(connection,t)
		
	elif role == 3:
		if val.upper() == "TEAM NAME":
			h1 = "Players of Team "+ str(t)
			r1 = get_team_players(connection,t)
		elif val.upper() == "PLAYER NAME":
			h1 = "Player Details for: " + str(t)
			r1 = get_player_data(connection,t)

	elif role == 4:
		if val.upper() == "PLAYER NAME":
			h1 = "Owner Details for Player "+ str(t)
			r1 = get_owner_details_for_players(connection,t)
		
	elif role == 5:
		if val.upper() == "GROUND NAME":
			h1 = "Details of Matches in "+ str(t)
			r1 = get_no_of_matches_in_ground(connection,t)
		elif val.upper() == "TEAM NAME":
			h1 = "Homeground for: "+ str(t)
			r1 = get_homeground_of_team(connection,t)

	elif role == 6:
		if val.upper() == "PLAYER NAME":
			h1 = "Base Price for "+ str(t)
			r1 = get_base_price_for_players(connection,t)

	elif role == 7:
		if val.upper() == "TABLE NAME":
			h1 = "ALL RECORDS IN "+ str(t)
			r1 = get_table(connection,t)	

	elif role == 9:
		if val.upper() == "SPONSOR NAME":
			h1 = "Teams Sponsored by "+ str(t)
			r1 = get_teams_sponsored_by(connection,t)
		
	elif role == 8:
		if val.upper() == "OFFICIAL NAME":
			h1 = "Matches for "+ str(t)
			r1 = get_officials_matches(connection,t)
		elif val.upper() == "MATCH NO":
			h1 = "Officials For Match No."+ str(t)
			r1 = get_officials_of_match(connection,t)

	elif role == 10:
		if val.upper() == "MATCH No":
			h1 = "Broadcaster for Match No."+ str(t)
			r1 = get_commentators_of_match(connection,t)
	
	return [r1,h1]

try:
	USERS= load()
except:
	USERS = {}
	save(USERS)
cur_user = None
global name

##############################################################################################################################

## WEB APP

@app.route("/login.html")
def login():
	global name
	USERS = load()
	display ="SIGN IN"
	try:
		display = request.args['display']
	except:
		display = "SIGN IN"
	return render_template("login.html",display=display)

@app.route("/login.html", methods=['POST'])
def login_name():
	global name
	USERS = load()
	nam = request.form['username']
	password = request.form['pass']
	role = request.form['role']
	aff = request.form['aff']
	name = nam.upper()
	password = password.upper()
	role = role.upper()
	aff = aff.upper()
	t = aff
	display = "Sign In"
	role_no = 0
	if len(name) == 0:
		display = "Please Enter Your Name"
		return redirect(url_for('login', display=display))
	if len(password) == 0:
		display = "Please Enter Your Password"
		return redirect(url_for('login', display=display))
	if len(role) == 0:
		display = "Please Enter Your Role"
		return redirect(url_for('login', display=display))

	try:
		role_no = Role[role]
	except:
		display = "Please Enter a valid Role"
		return redirect(url_for('login', display=display))		

	if name not in USERS:
		if len(aff)==0:
			aff="Guest"
		USERS[name] = User(name,password,role,role_no,aff,t)
	else:
		if USERS[name].password != password:
			display = "Incorrect Password"
			return redirect(url_for('login', display=display))
		if USERS[name].role != role:
			display = "Incorrect Role"
			return redirect(url_for('login', display=display))
	save(USERS)
	return redirect(url_for('dashboard',name=name))

@app.route("/user.html")
def user():
	global name
	USERS = load()
	cur_user = USERS[name]

	try:
		name = cur_user.name
		role = cur_user.role
		Affliation = cur_user.Affliation
		aff = cur_user.aff
		joinedOn = cur_user.joinedOn
		try: 
			r = rteam[aff]
		except:
			r = rteam["Guest"]
	except:
		return render_template("404.html")
	save(USERS)
	return render_template("user.html",team_img="../static/Images/team"+str(r)+".png",name=name,role=role,affliation=team[r],joinedOn=joinedOn)

@app.route("/tables.html")
def tables():
	global name
	USERS = load()
	cur_user = USERS[name]

	try:

		res1 = session.get('res',"")
		head1 = session.get('head',"Search")
		tableH = session.get('tablehead',"")

		session['res'] = ""
		session['head'] = "Search"
		session['tablehead'] = ""

		admin_only = ""

		name = cur_user.name
		role = cur_user.role
		role_no = cur_user.role_no
		Affliation = cur_user.aff
		aff = cur_user.Affliation
		joinedOn = cur_user.joinedOn
		t = cur_user.t

		if role_no == 7:
			te = list(Tables.values())
			admin_only = "Available DB's: "
			for i in te:
				admin_only += i + "  "

		############# EMBEDDED QUERIES ###############
		
		connection = create_connection()

		r1,r2,r3,r4,he1,he2,he3,he4 = getTable(role_no,connection,t)
		
		t1 , h1 = getData(r1)
		t2 , h2 = getData(r2)
		t3 , h3 = getData(r3)
		t4 , h4 = getData(r4)

		connection.close()

		##############################################

		performance_table0 = res1
		sub_performance_table0 = tableH

		performance_table1 = t1
		sub_performance_table1 = h1
	
		performance_table2 = t2
		sub_performance_table2 = h2

		performance_table3 = t3
		sub_performance_table3 = h3

		performance_table4 = t4
		sub_performance_table4 = h4

		
	except:
		return render_template("404.html")
	save(USERS)
	return render_template("tables.html",admin_only = admin_only,Heading=head1,h1=he1,h2=he2,h3=he3,h4=he4,sub_performance_table0=sub_performance_table0,sub_performance_table1=sub_performance_table1,sub_performance_table2=sub_performance_table2,sub_performance_table3=sub_performance_table3,sub_performance_table4=sub_performance_table4,performance_table0 = performance_table0,performance_table1 = performance_table1 ,performance_table2 = performance_table2 ,performance_table3 = performance_table3, performance_table4 = performance_table4)

@app.route("/notifications.html")
def overview():
	global name
	USERS = load()
	cur_user = USERS[name]

	try:
		name = cur_user.name
		role = cur_user.role
		role_no = cur_user.role_no
		Affliation = cur_user.aff
		aff = cur_user.Affliation
		joinedOn = cur_user.joinedOn

		f1 = None

		
		if role_no not in modDB:
			return render_template("permission_denied.html")

		else:
			if role_no == 1:
				f1 = Manager()
		

			if role_no == 3:
				f1 = PlayerBoard()
		

			if role_no == 5:
				f1 = CricketGroundCommittee()
		

			if role_no == 6:
				f1 = AuctionCommittee()
		

			if role_no == 7:
				f1 = admin()
		

	except:
		return render_template("404.html")
	save(USERS)
	return render_template("notifications.html",form1=f1)

@app.route("/home.html")
def home():
	global name
	USERS = load()
	cur_user = USERS[name]

	try:
		name = cur_user.name
		role = cur_user.role
		Affliation = cur_user.aff
		aff = cur_user.Affliation
		joinedOn = cur_user.joinedOn
	except:
		return render_template("404.html")
	save(USERS)
	return render_template("home.html")

@app.route("/dashboard.html")
def dashboard():

	global name
	USERS = load()
	cur_user = USERS[name]
	try:
		name = cur_user.name
		role = cur_user.role
		Affliation = cur_user.aff
		aff = cur_user.Affliation
		joinedOn = cur_user.joinedOn
		growth = cur_user.growth
		tot_rev = cur_user.tot_rev

		############# EMBEDDED QUERIES ###############
		
		connection = create_connection()
		t1 = get_top_teams_points(connection)
		t2 = get_top_teams_fairplay(connection)
		t3 = get_orange_cap(connection)
		t4 = get_purple_cap(connection)

		topTeamName = t1[0]['team_name']
		team_top_no = rteam[topTeamName]
		
		table1 , head1 = getData(t1)
		table2 , head2 = getData(t2)

		match_lost = t4[0]['player_name']
		match_won = t3[0]['player_name']

		connection.close()

		##############################################

		graph = "../static/Images/team"+str(team_top_no)+".png"
		table_on_dash1 = table1
		sub_table_on_dash1 = head1
		table_on_dash2 = table2
		sub_table_on_dash2 = head2

	except:
		return render_template("404.html")
	save(USERS)
	return render_template("dashboard.html",sub_table_on_dash1=sub_table_on_dash1,sub_table_on_dash2=sub_table_on_dash2,follower=random.randint(0,200),match_lost = match_lost,match_won=match_won, tot_rev = tot_rev,name=name,picture= "../static/Images/match"+str(random.randint(1,10))+".jpg",graph=graph,table_on_dash1=table_on_dash1,table_on_dash2=table_on_dash2 )
	
@app.route("/notifications.html", methods=['POST'])
def inserter():
	global name
	insert_Form = [MATCHES_insert(),OfficialsForMatches_insert(),AUCTION_insert(),UMPIRES_insert(),PLAYERS_insert(),TEAMS_insert(),OWNERS_insert(),MANAGERS_insert(),GROUNDS_insert(),HOMEGROUND_insert(),SPONSORS_insert(),BROADCASTERS_insert(),COMMENTATORS_insert(),COMMENTATORSFORMATCH_insert()]
	USERS = load()
	cur_user = USERS[name]
	try:
		name = cur_user.name
	except:
		return render_template("404.html")
	choice_no = request.form['choice']
	form = None
	table_no = request.form["db"]
	tab = Tables[int(table_no)]
	session['tab'] = table_no
	save(USERS)
	if choice_no == '1':
		form = insert_Form[int(table_no)-1]
		return render_template("insert.html",form =form ,Table = Tables[int(table_no)])
	elif choice_no == '2':
		form = update_form()
		connection = create_connection()
		lis = get_table_columns(connection,tab)
		attr = ""
		for i in lis[:len(lis)-1]:
			attr += i[0] + ", "
		attr += lis[-1][0]
		print(attr)
		connection.close()
		return render_template("update.html",form =form ,Table = Tables[int(table_no)],attr=attr)
	else:
		form = delete_form()	
		return render_template("delete.html",form =form ,Table = Tables[int(table_no)])
	

@app.route("/insert.html", methods=['POST'])
def insert():
	global name
	USERS = load()
	cur_user = USERS[name]
	try:
		name = cur_user.name
	except:
		return render_template("404.html")
	a = [v for v in request.form]
	dic = {}
	for i in a[:len(a)-1]:
		dic[i] = request.form[i]
	print(dic)
	table_no = session['tab']
	table_no = int(table_no)
	session['tab'] = -1
	tab = Tables[table_no]
	li = [request.form[i] for i in a[:len(a)-1]]

	############# EMBEDDED QUERIES ###############
			
	connection = create_connection()
	add_data(connection,dic,tab)
	connection.close()

	##############################################

	save(USERS)
	return redirect(url_for('dashboard',name=name))

@app.route("/update.html", methods=['POST'])
def update():
	global name
	USERS = load()
	cur_user = USERS[name]
	try:
		name = cur_user.name
	except:
		return render_template("404.html")
	a = [v for v in request.form]
	# dic = {}
	# for i in a[:len(a)-1]:
	# 	dic[i] = request.form[i]
	# print(dic)
	table_no = session['tab']
	table_no = int(table_no)
	session['tab'] = -1
	tab = Tables[table_no]
	li = [request.form[i] for i in a[:len(a)-1]]

	id_for = li[0]
	key = li[1]
	" ".join(key.split())
	key = key.split(",")
	l = [" ".join(i.split()) for i in key]
	l = [i.split("=") for i in l]

	d = {}
	for i in range(len(l)):
		d[l[i][0]] = l[i][1]

	############# EMBEDDED QUERIES ###############
			
	connection = create_connection()
	lis = get_table_columns(connection,tab)
	lis = lis[0][0]
	update_data(connection,d,tab,lis,id_for)
	connection.close()

	##############################################

	save(USERS)
	return redirect(url_for('dashboard',name=name))


@app.route("/delete.html", methods=['POST'])
def delete():
	global name
	USERS = load()
	cur_user = USERS[name]
	try:
		name = cur_user.name
	except:
		return render_template("404.html")
	a = [v for v in request.form]
	dic = {}
	for i in a[:len(a)-1]:
		dic[i] = request.form[i]
	print(dic)
	table_no = session['tab']
	table_no = int(table_no)
	session['tab'] = -1
	tab = Tables[table_no]
	li = [request.form[i] for i in a[:len(a)-1]]

	############# EMBEDDED QUERIES ###############
			
	connection = create_connection()
	lis = get_table_columns(connection,tab)
	lis = lis[0][0]
	d = {}
	d[lis] = request.form["id_for"]
	delete_data(connection,d,tab)
	connection.close()

	##############################################

	save(USERS)
	return redirect(url_for('dashboard',name=name))



@app.route("/tables.html", methods=['POST'])
def select():
	global name
	USERS = load()
	cur_user = USERS[name]
	try:
		name = cur_user.name
		role_no = cur_user.role_no
	except:
		return render_template("404.html")

	try:
		a = [v for v in request.form]
		li = [request.form[i] for i in a]
		inp = li[0]
		" ".join(inp.split())
		l = inp.split("=")
		l = [" ".join(i.split()) for i in l]

		############# EMBEDDED QUERIES ###############
			
		connection = create_connection()
		r1, h1 = Serach(role_no,connection,l[1],l[0])
		t1 , he1 = getData(r1)
		connection.close()

		##############################################
		save(USERS)
		session['res'] = t1
		session['head'] = h1
		session['tablehead'] = he1

		return redirect(url_for('tables'))
	except:
		return redirect(url_for('tables',name=name))

if __name__ == "__main__":
	app.run(debug=True)