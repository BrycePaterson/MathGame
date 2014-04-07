local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gv = require("global")
 
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


--This is called automattically when Scene is called

local function home(event)
  storyboard.gotoScene("menu")
end

local function writeProgress()

  local path = system.pathForFile("progress.txt",system.DocumentsDirectory)
  local file = io.open(path, "w+")
  
  for x = 0, 3 do
    file:write(gv.progress[x].."\n")
  end
  
  io.close(file)
  file = nil

end

function scene:createScene( event )
  group = self.view
	
	background(group)
  
	local text = display.newText("The Game is over",200,gv.height/2,"Georgia",50)
   text:setTextColor(200,200,200)
   text:rotate(-90)
   group:insert(text)
   
   local winner
   
   --the player wins
   if(gv.winner==1) then
		winner = display.newText("YOU WIN",400,gv.height/2,"Georgia",50)
		winner:setTextColor(0,0,0)
		winner:rotate(-90)
		group:insert(winner)
		
		local winnings = display.newText("You won "..(2*gv.level).." gold",300,gv.height/2,"Georgia",50)
		winnings:setTextColor(0,0,0)
		winnings:rotate(-90)
		group:insert(winnings)
		
		gv.gold = gv.gold + gv.level*2
		writeMoney(false)
		
		--local text = display.newText(gv.progress[section],200,100,"Georgia",50)
    --text:setTextColor(200,200,200)
    
    --local text = display.newText(gv.levelPlayed,200,300,"Georgia",50)
    --text:setTextColor(200,200,200)
   
		if gv.progress[gv.section] < 9  and gv.progress[gv.section] == gv.levelPlayed then
		   gv.progress[gv.section] = gv.progress[gv.section] + 1
		   writeProgress()
	  end
   end
   --the computer wins
   if(gv.winner==0) then
		winner = display.newText("BADDICUS WON!",400,gv.height/2,"Georgia",50)
		winner:setTextColor(250,0,0)
		winner:rotate(-90)
		group:insert(winner)
   end
   --home button
	local home = widget.newButton{
  x = 50,
  y = gv.height - 100,
  defaultFile = "Home.png",
  onEvent = home,
  }
  home:rotate(-90)
  home:scale(0.5,0.5)
  group:insert(home)
  
  
   local cc = display.newImage("questionbox.png")
	cc:rotate(-90)
	cc:scale(1,1)
	cc.y = gv.height/2 - 300
	cc.x = 400
	cc.xScale = 0.3
	cc.yScale = 0.5
 	
 	group:insert(cc)
 	
 	money = display.newText("$"..gv.gold,cc.x,gv.height/2 - 300,"Greorgia",50)
 	money:rotate(-90)
 	money:setTextColor(0,0,0)
 	
 	group:insert(money)
  
end
 
-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
 
 
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  
 
end
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  
  --group:remove(title)
 
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