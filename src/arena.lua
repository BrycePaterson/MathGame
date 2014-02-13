-- TO DO
--		Add daeath catching condition RAFFI (DONE)
--		player pictures BRYCE (DONE)
--		add "correct" and "incorrect" RAFFI (DONE methods made but not implemented yet. need timers to work properly)
--		hit animation (players pictures flashing) BRYCE (Need timer to make it work as well
--		sounds  (mp3 files for background music, hit, and miss)
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
local level = {}
local extra = {}
local group
local q
local answer = ""
local enemy
local player
local over = false
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--------------------------------------------------------------------------------- 
 
--function to change the numbers in the question
function changeValues()
	a = math.random(0,r)
	b = math.random(0,r)
end

--function to get the answer of the question
function getAnswer()
	return (a+b)
end

--question to return a string of the question
function questionToString()
	return a.." + "..b.." = "
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
 	
 	timer.performWithDelay( 1000, revert)
 end
 
 
 --function called to determine if the enemy lands a hit
function enemyHit()
	if(math.random()<=hr) then
		player_health = player_health-1	
		if(player_health == 0)then
			gv.winner = 0
			over = true
			storyboard.gotoScene("gameOver")
		end
	end
end

--function called to determine if the player lands a hit. Parameter: user input
function playerHit(answer)
	if(answer==getAnswer()) then
		--showColor(1)
		computer_health=computer_health-1
		if (computer_health == 0) then
			gv.winner = 1
			over = true
			storyboard.gotoScene("gameOver")
		end
	end
	
	--showColor(0)
end

--function to display a health of either player as a fraction
function displayHealth(health)
	return health.."/5"
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
        	group:remove(level[i][j])
        end
        group:remove(extra[i])
    end
end

local function addCalc()
	for i = 0, 2 do --row
        for j = 0, 2 do --column
        	group:insert(level[i][j])
        end
        group:insert(extra[i])
    end
end

local function enemyTurn()
	removeCalc()
	enemyHit()
	if (over == false)then
		player.text = displayHealth(player_health)
		answer = ""
		changeValues()
		showQuestion()
		addCalc()
	end
end


local function enter(event)
	if event.phase == "began" then
		playerHit(tonumber(answer))
		enemy.text = displayHealth(computer_health)
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
                defaultFile = "square.png",
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
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
                defaultFile = "square.png",
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
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
                defaultFile = "square.png",
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
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
                defaultFile = "square.png",
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
				onEvent = enter
          }
	extra[2]:rotate(-90)
	group:insert(extra[2])
end
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
	group = self.view
    
	local arena = display.newImage("Arena.png")
	arena.x = 235
	arena.y = 450
	arena.xScale = 1.1
	arena.yScale = 1.1	
	group:insert(arena)
	
	local good_guy = display.newImage("Good_Guy.png")
	good_guy.x = 320
	good_guy.y = gv.height-150
	good_guy:rotate(-90)
	group:insert(good_guy)
	
	local bad_guy = display.newImage("Bad_Guy.png")
	bad_guy.x = 320
	bad_guy.y = 150
	bad_guy:rotate(-90)
	group:insert(bad_guy)
	
	player = display.newText(displayHealth(player_health),120,gv.height-60,"Georgia",50)
	player:setTextColor(240,0,0)
	player:rotate(-90)
	group:insert(player)
	enemy=display.newText(displayHealth(computer_health),120,60,"Georgia",50)
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