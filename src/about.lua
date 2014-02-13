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

local function home(event)

  storyboard.gotoScene("menu")

end

--This is called automattically when Scene is called
function scene:createScene( event )
    local group = self.view
  
  background(group)
  
   local text = display.newText("This game was made by Raffi Kudlac and Bryce Paterson",100,gv.height/2,"Georgia",30)
   local sound = display.newText("Sounds and Music From: http://www.freesfx.co.uk",200,gv.height/2,"Georgia",30)
   local img = display.newText("Gladiator and arena images by Bryce Paterson",300,gv.height/2,"Georgia",30)
   local back = display.newText("Background image from: http://www.upphotos.net",400,gv.height/2,"Georgia",30)
   text:setTextColor(200,200,200)
   
   text:rotate(-90)
   sound:rotate(-90)
   img:rotate(-90)
   back:rotate(-90)
   group:insert(sound)
   group:insert(text)
   group:insert(img)
   group:insert(back)

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