#RESOURCES
CUR_DIR			= $(shell pwd)
TERM_PATH		= /Applications/Utilities/terminal.app
API 			= fansi-api/ 
HTML5 			= fansi-html5/
DASHBOARD 		= fansi-dashboard/
HOST 			= $(shell hostname)/
ARGS 			= null
FLAGS 			= 
GITAPI			= https://github.com/fan-si/fansi-api.git
GITHTML5		= https://github.com/fan-si/fansi-html5.git
GITDASHBOARD	= https://github.com/fan-si/fansi-dashboard.git

run:
	@echo
	@echo *********Welcome to the Fan.si makefile.*********
	@echo This tool was created with the intention of making things slightly easier, and faster when dealing with Github. To get your everything set up running \> make setup
	@echo For more tools and help: \> make help
	@echo

help:
	@echo 
	@echo There are a number of commands at your discretion. For more information on any command set in particular EXAMPLE: make basiccmd 
	@echo "basiccmd		:these are basic replacement commands setup for API-, HTML5-, and DASH-."
	@echo "checkout 	:runs git checkout commands for switching the current branch"
	@echo "clone		:tools to clone from master branch. Branch urls are saved in GITAPI, GITHTML5, and GITDASHBOARD"
	@echo "commit 		:runs git commits for current git branch. NOTE: POSSIBLE TO ADD A AUTO PUSH WITH THIS"
	@echo "delete 		:removes $(API), $(HTML5), and $(DASHBOARD) local directories and contents"
	@echo "deploy 		:runs git push commands to deploy to heroku and heroku-dev"
	@echo "diff 		:checks the git diff of $(API), $(HTML5), and $(DASHBOARD) to their current branches"
	@echo "push 		:runs git push commands for pushing to specified git branch"
	@echo "resources 	:prints all default/set resources"
	@echo "server		:used to start running the local servers. NOTE: This does not currently check if GoogleAppEngine is installed or working properly."	
	@echo "setup		:will clone API, HTML5, and DASHBOARD to your current directory. It will then attempt to run all 3 terminals in a new windows using the basic \n\t\t\t Terminal. NOTE: This does not currently check if GoogleAppEngine is installed or working properly."
	@echo "status 		:runs git status for current git branch."
	@echo

resources:
	@echo
	@echo The default resources are set to:
	@echo CUR_DIR '\t' 		= $(CUR_DIR)""
	@echo TERM_PATH '\t'	= $(TERM_PATH)""
	@echo API 	'\t\t'		= $(API)""
	@echo HTML5 '\t\t'		= $(HTML5)""
	@echo DASHBOARD '\t'	= $(DASHBOARD)""
	@echo HOST '\t\t'		= $(HOST)""
	@echo FLAGS '\t\t'		= $(FLAGS)""
	@echo GITAPI '\t\t'		= $(GITAPI)""
	@echo GITHTML5 '\t'		= $(GITHTML5)""
	@echo GITDASHBOARD '\t' = $(GITDASHBOARD)""
	@echo

currentDir:
	@echo $(CUR_DIR)

hostname:
	@echo $(HOST)

setup: CloneMaster 
	@make ServerMasterW

############################ GIT GOD COMMANDS ############################
basiccmd:
	@echo 
	@echo General useage git commands. cd into chosen directory and runs your command with -git- amended to the front
	@echo '\t' EXAMPLE: ">" make API-'"diff"' runs the following: '\n\t'cd fansi-api/ '\n\t'git diff
API-%:
	@cd $(API);			git $(@:API-%=%)
HTML5-%:
	@cd $(HTML5);		git $(@:HTML5-%=%)
DASH-%:
	@cd $(DASHBOARD);	git $(@:Dashboard-%=%)

#########################################################################
############################ GITHUB COMMANDS ############################
#########################################################################

############################ CLONING ############################
clone:
	@echo
	@echo These are the rulings in using the "make clone" commands.
	@echo cloneMaster "\t\t"	:Clones API, HTML5, and DASHBOARD from master. Also remote adds heroku to the new directories.
	@echo cloneAPI "\t\t"		:Clones API 		in current dir. Runs: git clone $(GITAPI)
	@echo cloneHTML5 "\t\t"		:Clones HTML5 		in current dir. Runs: git clone $(GITHTML5)
	@echo cloneDashboard "\t\t"	:Clones Dashboard 	in current dir. Runs: git clone $(GITDASHBOARD)
	@echo 

CloneMaster: cloneAPI cloneHTML5 cloneDashboard 
	@echo Completed cloning all of Git Hub's Master 
cloneAPI:
	@echo ***Cloning Master API***
	@git clone $(GITAPI)
cloneHTML5:
	@echo ***Cloning Master HTML5***
	@git clone $(GITHTML5)
	@cd $(HTML5); git remote add heroku git@heroku.com:fansi-html5.git; git remote add heroku-dev git@heroku.com:dev-fansi-html5.git
cloneDashboard:
	@echo ***Cloning Master Dashboard***
	@git clone $(GITDASHBOARD)
	@cd $(DASHBOARD); git remote add heroku git@heroku.com:fansi-dashboard.git; git remote add heroku-dev git@heroku.com:dev-fansi-dashboard.git


############################### STATUS ###############################
status: 
	@echo
	@echo These are the commands for git status checking.
	@echo statusMaster "\t\t"	:Checks status of API, HTML5, and DASHBOARD from current branch.
	@echo statusAPI "\t\t"		:Checks status of API 			in current branch. Runs: git -C $(API) status
	@echo statusHTML5 "\t\t"	:Checks status of HTML5 		in current branch. Runs: git -C $(HTML5) status
	@echo statusDashboard "\t"	:Checks status of Dashboard 	in current branch. Runs: git -C $(DASHBOARD) status
	@echo 

StatusMaster: statusAPI statusHTML5 statusDashboard
statusAPI:
	@echo
	@echo ***API Status***
	@git -C $(API) status
statusHTML5:
	@echo
	@echo ***HTML5 Status***
	@git -C $(HTML5) status
statusDashboard:
	@echo
	@echo ***Dashboard Status***
	@git -C $(DASHBOARD) status


############################### COMMITING ###############################
commit: 
	@echo
	@echo These are the rulings in using the "make commit" functions.
	@echo commitAPI-% '\t\t\t'		:Commits API 		to current branch. Runs: git commit -am "%" in API
	@echo commitHTML5-% '\t\t\t'	:Commits HTML5 		to current branch. Runs: git commit -am "%" in HTML5
	@echo commitDashboard-% '\t\t'	:Commits Dashboard 	to current branch. Runs: git commit -am "%" in Dashboard
	@echo 

commitAPI-%:
	@cd $(API); git commit -am "$(@:commitAPI-%=%)"
commitHTML5-%:
	@cd $(HTML5); echo git commit -am "$(@:commitHTML5-%=%)"
commitDashboard-%:
	@cd $(DASHBOARD); git commit -am "$(@:commitDashboard-%=%)"


############################### PUSHING ###############################
push:
	@echo
	@echo These are the rulings in using the "make push" functions
	@echo PushMaster '\t\t\t'		:Pushes API, HTML5, and Dashboard to "origin master"
	@echo pushAPI-% '\t\t\t'		:Pushes API 		to % branch formating: make pushAPI-"branchname"
	@echo pushHTML5-% '\t\t\t'		:Pushes HTML5 		to % branch formating: make pushHTML5-"branchname"
	@echo pushDashboard-% '\t\t'	:Pushes Dashboard 	to % branch formating: make pushDashboard-"branchname"
	@echo 

PushMaster: pushAPI-"origin\ master" pushHTML5-"origin\ master" pushDashboard-"origin\ master"
pushAPI-%:
	@cd $(API); echo git push origin $(@:pushAPI-%=%)

pushHTML5-%:
	@cd $(HTML5); git push origin $(@:pushHTML5-%=%)

pushDashboard-%:
	@cd $(DASHBOARD); git push origin $(@:pushDashboard-%=%)


############################### CHECKOUT ###############################
checkout:
	@echo
	@echo These are the rulings in using the \"make push\" functions. To create the branch just add -b to the start of it.
	@echo checkoutMaster '\t\t'		:Checkout API, HTML5, and Dashboard branches to specified branch""
	@echo checkoutAPI-% '\t\t'		:Checkout API 			to % branch: make checkoutAPI-"mybranch"
	@echo checkoutHTML5-% '\t'		:Checkout HTML5 		to % branch: make checkoutHTML5-"mybranch"
	@echo checkoutDashboard-% '\t'	:Checkout Dashboard 	to % branch: make checkoutDashboard-"mybranch"	
	@echo 

checkoutMaster-%: checkoutAPI-% checkoutHTML5-% checkoutDashboard-%
checkoutAPI-%: 
	@cd $(API); git checkout $(@:checkoutAPI-%=%)
checkoutHTML5-%: 
	@cd $(HTML5); git checkout $(@:checkoutHTML5-%=%)
checkoutDashboard-%: 
	@cd $(DASHBOARD); git checkout $(@:checkoutDashboard-%=%)


############################### DEPLOY ###############################
deploy:
	@echo
	@echo These are the rulings in using the \"make deploy\" functions. NOTE: THE API ONE NEEDS TO BE FIXED CURRENTLY DOES NOT WORK PROPERLY
	@echo deployMaster '\t\t'		:Deploys API, HTML5, and Dashboard to heroku master""
	@echo deployDevMaster '\t'		:Deploys API, HTML5, and Dashboard to heroku-dev master""
	@echo deployAPI-% '\t\t' 		:Deploys API 		by pushing % to heroku: make deployAPI-\"branchName\"""
	@echo deployHTML5-% '\t\t' 		:Deploys HTML5 		by pushing % to heroku: make pushHTML5-\"branchName\"""
	@echo deployDashboard-% '\t'	:Deploys Dashboard 	by pushing % to heroku: make pushDashboard-\"branchName\"""
	@echo

deployMaster: deployAPI-"heroku" deployHTML5-"heroku" deployDashboard-"heroku"
deployDevMaster: deployAPI-"heroku-dev" deployHTML5-"heroku-dev" deployDashboard-"heroku-dev"
deployAPI-%:
	@echo ***NEEDS TO BE IMPLEMENTED***
#	@cd $(API); echo git push $(@:deployAPI-%=%)
deployHTML5-%:
	@cd $(HTML5); git push $(@:deployHTML5-%=%)
deployDashboard-%:
	@cd $(DASHBOARD); git push $(@:deployDashboard-%=%)


############################### TESTING ###############################
StatusTestMaster: statusTestAPI statusTestHTML5 statusTestDashboard
	@echo Creating logs of all status tests
statusTestAPI:
	@git -C fansi-api/ status > status-api.txt
statusTestHTML5:
	@git -C fansi-html5/ status > status-html5.txt
statusTestDashboard:
	@git -C fansi-dashboard/ status > status-dashboard.txt

ClearStatus:
	@echo ***Removing all status test logs***
	@rm status-api.txt
	@rm status-html5.txt
	@rm status-dashboard.txt


############################ DIFF ############################
diff:
	@echo
	@echo These are the rulings in using the \"make deploy\" functions. NOTE: THE API ONE NEEDS TO BE FIXED CURRENTLY DOES NOT WORK PROPERLY
	@echo diffMaster '\t\t'		:Checks dif of $(API), $(HTML5), and $(DASHBOARD) and their current branchs""
	@echo diffAPI '\t\t' 		:Checks dif of $(API) 		to current branch""
	@echo diffHTML5 '\t\t' 		:Checks dif of $(HTML5)		to current branch""
	@echo diffDashboard '\t\t'	:Checks dif of $(DASHBOARD) to current branch""
	@echo

diffMaster: DiffAPI DiffHTML5 DiffDashboard
diffAPI:
	@cd $(API); echo "***API Git Diff***"; git diff

diffHTML5:
	@cd $(HTML5); echo "***HTML5 Git Diff***"; git diff

diffDashboard:
	@cd $(DASHBOARD); echo "***Dashboard Git Diff***"; git diff


############################ DELETE ############################
delete:
	@echo
	@echo These are the rulings in using the \"make deploy\" functions. NOTE: THE API ONE NEEDS TO BE FIXED CURRENTLY DOES NOT WORK PROPERLY
	@echo deleteMaster '\t\t'	:Deletes $(API), $(HTML5), and $(DASHBOARD) local directories and contents""
	@echo deleteAPI '\t\t' 		:Deletes $(API) 		local directory and contents""
	@echo deleteHTML5 '\t\t' 	:Deletes $(HTML5)		local directory and contents""
	@echo deleteDashboard '\t'	:Deletes $(DASHBOARD) 	local directory and contents""
	@echo
DeleteMaster: deleteAPI deleteHTML5 deleteDashboard ClearStatus
	@echo ***Finished Clearing all files.***
deleteAPI:
	@echo ***Clearing all api folders.***	
	@rm -rf fansi-api
deleteHTML5:
	@echo ***Clearing all html5 folders.***
	@rm -rf fansi-html5
deleteDashboard:
	@echo ***Clearing all dashboard folders.***
	@rm -rf fansi-dashboard


############################ SERVERS STARTS ############################
server:
	@echo 
	@echo These are the rulings in using the \"make server\" functions. NOTE: THE BACKGROUND SERVERS LEAVE ZOMBIE PROCESSES
	@echo ServerMasterW '\t\t'	:Runs API, HTML5, and DASHBOARD local servers in new window. NOTE: uses Terminal""
	@echo ServerMasterB '\t\t'	:Runs API, HTML5, and DASHBOARD local servers in background""
	@echo apiServer '\t\t' 		:Runs API		local server in current terminal""
	@echo html5Server '\t\t' 	:Runs HTML5		local server in current terminal""
	@echo dashboardServer '\t'  :Runs DASHBOARD	local server in current terminal""
	@echo NOTE: You may add B or W to the end of a solo server start to make it open in the background or windowed. EXAMPLE: make apiServerW""
	@echo 

# Starts all 3 servers in new windows
ServerMasterW: apiServerW html5ServerW dashboardServerW
	@sleep 7
	@echo Servers Running in new windows	

#Starts all 3 servers in background
ServerMasterB: apiServerB html5ServerB dashboardServerB
	@sleep 7
	@echo Servers Running	


# RUN SERVERS NORMALLY #
apiServer:
	@cd $(API); echo "***API Local Server Start Normal***";\
	 dev_appserver.py dispatch.yaml app.yaml worker-backend.yaml data-backend.yaml

html5Server:
	@cd $(HTML5); echo "***HTML5 Local Server Start Normal***";\
	 npm start

dashboardServer:
	@cd $(DASHBOARD); echo "***Dashboard Local Server Start Normal***";\
	 npm start

# RUN SERVERS IN NEW WINDOW #
apiServerW:
	@echo ***API Local Server Start New Window***
	@osascript -e 'tell app "Terminal" to do script "cd $(CUR_DIR); make apiServer"'

html5ServerW:
	@echo ***HTML5 Local Server Start New Window***
	@osascript -e 'tell app "Terminal" to do script "cd $(CUR_DIR); make html5Server"'

dashboardServerW:
	@echo ***Dashboard Local Server Start New Window***
	@osascript -e 'tell app "Terminal" to do script "cd $(CUR_DIR); make dashboardServer"'

AppEngine:	
	@echo ***Ensure Google App Engine is open***
	@open -g /Applications/GoogleAppEngineLauncher.app

# RUN SERVERS IN BACKGROUND THESE CREATE ZOMBIE PROCESSES #
apiServerB:
	@cd $(API); echo "***API Local Server Start Background***";\
	 dev_appserver.py dispatch.yaml app.yaml worker-backend.yaml data-backend.yaml  $(FLAGS) &

html5ServerB:
	@cd $(HTML5); echo "***HTML5 Local Server Start Background***";\
	 npm start $(FLAGS) &

dashboardServerB:
	@cd $(DASHBOARD); echo "***Dashboard Local Server Start Background***";\
	 npm start $(FLAGS) &



############################### TESTING ###############################
#Runs all available prebuilt tests
test: testapi testhtml5 testdashboard
testapi:
	@echo ***Running API Testing***
	@cd $(API); echo "***Running API Testing***";\
	 make test

testhtml5:
	@echo ***No HTML5 Tests Exist***

testdashboard:
	@echo ***No DASHBOARD Tests Exist***


############################### ALTERNATE COMMANDS ###############################
deletemaster: DeleteMaster
deleteMaster: DeleteMaster
deleteall: DeleteMaster
deleteAll: DeleteMaster
DeleteAll: DeleteMaster

clonemaster: CloneMaster
cloneMaster: CloneMaster
cloneall: CloneMaster
cloneAll: CloneMaster
CloneAll: CloneMaster

statusmaster: StatusMaster
satusMaster: StatusMaster
statusall: StatusMaster
statusAll: StatusMaster
SatutsAll: StatusMaster

servermaster: ServerMaster
serverMaster: ServerMaster
serverall: ServerMaster
serverAll: ServerMaster
ServerAll: ServerMaster
servers: ServerMaster

statusM: StatusMaster
StatusM: StatusMaster
statusAll: StatusMaster
statusMaster: StatusMaster
statusmaster: StatusMaster

Commit: commit

DiffMaster: diffMaster
diffAll: diffMaster

deployAll: deployMaster
deployALL: deployMaster
deployDevAll: deployDevMaster
deployAllDev: deployDevMaster

#
#This will take the command as make push-"VARIABLE"
#Then you may use $(@:push-%=%) to view the VARIABLE inside
#This method is extremely useful (esp in the case of -am commiting)
#
#push-%:
#	$(@:push-%=%)
#

#
#get brackethighlighter extension for Sublime

#	\ or && is used to continue the same line