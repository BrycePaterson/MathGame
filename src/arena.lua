-- TO DO
--		Add daeath catching condition RAFFI (DONE)
--		player pictures BRYCE (DONE)
--		add "correct" and "incorrect" RAFFI (DONE methods made but not implemented yet. need timers to work properly)
--		hit animation (players pictures flashing) BRYCE(Need timer to make it work as well)
--		sounds  (mp3 files for background music, hit, and miss), DONE
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gv = require("global")
--local height = display.contentHeight
--local width = display.contentWidth

gv.height = display.contentHeight
gv.width = display.contentWidth
local r = gv.range
local hr = gv.hit
local a= math.random(0,r)
local b= math.random(0,r)
local player_health = 5
local computer_health = 5
local bad_healthbar
local bad_healthbar_health
local good_healthbar
local good_healthbar_health
local level = {}
local extra = {}
local group
local q
local answer = ""
local enemy
local player
local over = false
local hit_mp3 = audio.loadStream("sword_swipe(HIT).mp3")
local miss_mp3 = audio.loadStream("shield_impact_with_sword(MISS).mp3")
-- local forward references should go here --
local L = gv.level
local t = 0
local time = 0
local total_time = 0
local corr = 0
local incorr = 0 
local divanswer =0

local calcpic = "Stone.png"
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--------------------------------------------------------------------------------- 
--function for writing our analytics to a file
function write()
	local path = system.pathForFile("addition.txt",system.DocumentsDirectory)
	local file = io.open(path, "a")
	
	
	t2 = os.date('*t')
	t3 = os.time(t2)
	total_time = t3 - time
	local total = corr + incorr
	file:write("\n\nLevel= "..L.."\nTime Spent= "..total_time.."\nQuestions Asked= "..total.."\nCorrect= "..corr.."\nWrong= "..incorr)
	io.close(file)
	file = nil
end
--function to change the numbers in the question
function changeValues()

  if gv.section == 1 then
      a = math.random(0,r/2)
      b = math.random(r/2,r)
  elseif gv.section == 3 then
      a = math.random(1,r)
      divanswer = math.random(1,r)
      b = a * divanswer
  else
	   a = math.random(0,r)
	   b = math.random(0,r)
   end
end

--function to get the answer of the question
function getAnswer()
	
	if gv.section ==0 then
	   return (a+b)
  elseif gv.section == 1 then
     return (b-a)
  elseif gv.section == 2 then 
     return (a*b)
  else
     return (b/a) 
  end
end

--question to return a string of the question
function questionToString()
	
	if gv.section ==0 then
     return a.." + "..b.." = "
  elseif gv.section == 1 then
     return b.." - "..a.." = "
  elseif gv.section == 2 then 
     return a.." x "..b.." = "
  else
     return b.." / "..a.." = "
   end
end
 
local function showQuestion()
	
	local box = display.newImage("questionbox.png")
	box:rotate(-90)
	box:scale(1,1)
	box.y = gv.height/2
	box.xScale = 0.7
	
	q = display.newText(questionToString(),35,gv.height/2,"Georgia",50)
	q:rotate(-90)
	q:setTextColor(0,0,0)
	
	group:insert(box)
	group:insert(q)
	
	
end

function showAnswer()
	q.text = q.text..getAnswer()
end

 local function revert()
 	q:setTextColor(0,0,0)
 end
 
 local function showColor(rw)
 
 	if (rw == 0)then
 		q:setTextColor(250,0,0)
	else
 		q:setTextColor(0,250,0)
 	end
 end
 
 --function to play hit sound
 function hitSound()
	audio.play(hit_mp3)
 end
 
 --function to play miss sound
 function missSound()
	audio.play(miss_mp3)
 end
 
 function correct()
	q.text = "CORRECT!"
	showColor(1)
	timer.performWithDelay(1000,revert)
	corr = corr+1
 end
 
 function wrong()
	showColor(0)
	q.text = "WRONG: "..getAnswer()
	showColor(0)
	timer.performWithDelay(1000,revert)
	incorr = incorr + 1
 end
 --function called to determine if the enemy lands a hit
function enemyHit()
	if(math.random()<=hr) then
		showAnswer()
		hitSound()
		player_health = player_health-1
		player.text = displayHealth(player_health)
		good_healthbar_health.xScale = 0.7*player_health/5
		good_healthbar_health.y = gv.height-110+(295*0.7/10)*(5-player_health)
		if(player_health == 0)then
			group:remove(good_healthbar_health)
			gv.winner = 0
			over = true
			write()
			storyboard.gotoScene("gameOver")
		end
	else
		q.text = q.text..getAnswer()-1
		missSound()
	end
end

function win()
	write()
	storyboard.gotoScene("gameOver")
end
--function called to determine if the player lands a hit. Parameter: user input
function playerHit(answer)
	if(answer==getAnswer()) then
		correct()
		computer_health=computer_health-1
		bad_healthbar_health.xScale = 0.7*computer_health/5
		bad_healthbar_health.y = 110-(295*0.7/10)*(5-computer_health)
		hitSound()
		if (computer_health == 0) then
			group:remove(bad_healthbar_health)
			gv.winner = 1
			over = true
			timer.performWithDelay(1000,win)
		end
	else
		wrong()
		missSound()
	end
end

--function to display a health of either player as a fraction
function displayHealth(health)
	return health.."/5"
end

local function input(event)

	if event.phase == "began" and answer:len() < 3 then 
		local s = event.target
		s = s:getLabel()
		answer = answer..s
		q.text = q.text..s
	end
end

local function clear(event)

	if event.phase == "began" then
		q.text = questionToString()
		answer = ""
	end


end

local function removeCalc()
	for i = 0, 2 do --row
        for j = 0, 2 do --column
        	level[i][j].isVisible = false
        end
        extra[i].isVisible = false
    end
end

local function addCalc()
	
		for i = 0, 2 do --row
			for j = 0, 2 do --column
				level[i][j].isVisible = true
			end
			extra[i].isVisible = true
		end
end

function initQuestion()
	answer = ""
	changeValues()
	q.text = questionToString()
	addCalc()
end

 local function enemyTurn()
	--timer.performWithDelay(5000,addCalc())
	changeValues()
	timer.performWithDelay(1000,showQuestion)
	timer.performWithDelay(3000,enemyHit)
	timer.performWithDelay(5000,initQuestion)
end

local function enter(event)
	if event.phase == "began" then
		playerHit(tonumber(answer))
		enemy.text = displayHealth(computer_health)
		removeCalc()
		if (over == false)then
			enemyTurn()
		end
	end
end

local function makeCalc()

	local dx = 100
    local dy = 100

    --used to created level grid
    for i = 0, 2 do --row
        level[i] = {}
        for j = 0, 2 do --column
            level[i][j] = widget.newButton{
            	label = (j+1)*3-i,
                x = dx*j + 125,
                y = dy*i + 325,
                fontSize = 20,
                width = 80,
                height = 80,
                defaultFile = calcpic,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = input
          }
          --level[i][j]:scale(0.5,0.5)
          level[i][j]:rotate(-90)
          --level[i][j]:setLabel((j + 1)*3 - i)
          group:insert(level[i][j])
        end  
    end
	
	extra[0] = widget.newButton{
            	label = "CE",
                x = 425,
                y = 525,
                fontSize = 20,
                width = 80,
                height = 80,
                defaultFile = calcpic,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = clear
          }
	extra[0]:rotate(-90)
	group:insert(extra[0])
	
	extra[1] = widget.newButton{
            	label = "0",
                x = 425,
                y = 425,
                fontSize = 20,
                width = 80,
                height = 80,
                defaultFile = calcpic,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = input
          }
	extra[1]:rotate(-90)
	group:insert(extra[1])
	
	extra[2] = widget.newButton{
            	label = "=",
                x = 425,
                y = 325,
                fontSize = 30,
                width = 80,
                height = 80,
                defaultFile = calcpic,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = enter
          }
	extra[2]:rotate(-90)
	group:insert(extra[2])
end
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
	group = self.view
	t = os.date('*t')
	time = os.time(t)
    
	local arena = display.newImage("Arena.png")
	arena.x = 235
	arena.y = 450
	arena.xScale = 1.1
	arena.yScale = 1.1	
	group:insert(arena)
	
	local scroll = display.newImage("scroll.png")
	scroll.x = gv.width/2 + 30
	scroll.y = gv.height/2
	scroll.xScale = 0.75
	scroll.yscale = 0.05
	group:insert(scroll)
	
	local good_guy = display.newImage(gv.currentskin)
	good_guy.x = 320
	good_guy.y = gv.height-150
	good_guy:rotate(-90)
	group:insert(good_guy)
	
	local bad_guy
	
	if(gv.levelPlayed == 9) then
		bad_guy = display.newImage("Bad_complete.png")
	else
		 local numb = math.random(0,3)
		 local bad = {}
		 bad[0] = "Bad_Guy1_complete.png"
		 bad[1] = "Bad_Guy2_complete.png"
		 bad[2] = "Bad_guy3_complete.png"
		 bad_guy = display.newImage(bad[numb])
	 end
		 
	bad_guy.x = 320
	bad_guy.y = 145
	bad_guy:rotate(-90)
	group:insert(bad_guy)
	
	local good_background = display.newImage("Player_background.png")
	good_background.x = 65
	good_background.y = display.contentHeight-110
	good_background.xScale = 0.82
	good_background.yScale = 0.7
	good_background:rotate(-90)
	group:insert(good_background)
	
	local you = display.newText("YOU",50,gv.height-70,"Georgia",50)
	you:setTextColor(240,0,0)
	you:rotate(-90)
	group:insert(you)
	
	local bad_background = display.newImage("Player_background.png")
	bad_background.x = 65
	bad_background.y = 110
	bad_background.xScale = 0.82
	bad_background.yScale = 0.7
	bad_background:rotate(-90)
	group:insert(bad_background)
	
	local baddicus = display.newText("Badicus",50,150,"Georgia",35)
	baddicus:setTextColor(240,0,0)
	baddicus:rotate(-90)
	group:insert(baddicus)
	
	bad_healthbar = display.newImage("health_bar_background.png")
	bad_healthbar.x = 85
	bad_healthbar.y = 110
	bad_healthbar.xScale = 0.7
	bad_healthbar:rotate(-90)
	group:insert(bad_healthbar)
	
	bad_healthbar_health = display.newImage("health_bar_health.png")
	bad_healthbar_health.x = 85
	bad_healthbar_health.y = 110
	bad_healthbar_health.xScale = 0.7
	bad_healthbar_health:rotate(-90)
	group:insert(bad_healthbar_health)
	
	good_healthbar = display.newImage("health_bar_background.png")
	good_healthbar.x = 85
	good_healthbar.y = gv.height-110
	good_healthbar.xScale = 0.7
	good_healthbar:rotate(-90)
	group:insert(good_healthbar)
	
	good_healthbar_health = display.newImage("health_bar_health.png")
	good_healthbar_health.x = 85
	good_healthbar_health.y = gv.height-110
	good_healthbar_health.xScale = 0.7
	good_healthbar_health:rotate(-90)
	group:insert(good_healthbar_health)
	
	player = display.newText(displayHealth(player_health),50,gv.height-180,"Georgia",25)
	player:setTextColor(240,0,0)
	player:rotate(-90)
	group:insert(player)
	
	enemy=display.newText(displayHealth(computer_health),50,40,"Georgia",25)
	enemy:setTextColor(240,0,0)
	enemy:rotate(-90)
	group:insert(enemy)
	
	showQuestion()
	
	makeCalc()
end
 
-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
  
 
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  
 
end
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
 
 
end
 
-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
  
 
end
 
-- Called prior to the removal of scene's "view" (display view)
function scene:destroyScene( event )
  
 
end
 
-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
 
 
end
 
-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
 
 
end
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
 
-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )
 
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
 
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
 
-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )
 
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
 
-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )
 
-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )
 
---------------------------------------------------------------------------------
 
return scene