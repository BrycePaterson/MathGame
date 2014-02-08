local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gv = require("global")
--local height = display.contentHeight
--local width = display.contentWidth

gv.height = display.contentHeight
gv.width = display.contentWidth
local range = gv.range
local hr = gv.hit
local a= math.random(0,range)
local b= math.random(0,range)
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--------------------------------------------------------------------------------- 
 
--function to change the numbers in the question
function changeValues()
	a = math.random(0,range)
	b = math.random(0,range)
end

--function to get the answer of the question
function getAnswer()
	return (a+b)
end

--question to return a string of the question
function questionToString()
	return a.." + "..b.." ="
end
 
 --function called to determine if the enemy lands a hit
function enemyHit()
	if(math.random()<=hr) then
		player_health = player_health-1	
	end
end

--function called to determine if the player lands a hit. Parameter: user input
function playerHit(answer)
	if(answer==getAnswer()) then
		computer_health=computer_health-1
	end
end

--function to display a health of either player as a fraction
function displayHealth(health)
	return health.."/15"
end
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
    local arena = diaplay.newImage("Arena.png")
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