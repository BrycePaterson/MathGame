local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local gv = require("global")
gv.height = display.contentHeight
gv.width = display.contentWidth
local time_path = system.pathForFile("total_time.txt",system.DocumentsDirectory)
-- Clear previous scene
storyboard.removeAll()
local group
local localSkins ={}
local current = 3
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local function next(event)

end

local function prev(event)

end

local function displaySkin()


end


--This is called automattically when Scene is called
function scene:createScene( event )
 group = self.view
 background(group)
 
 --makes card background
 	box = display.newImage("card.png")
	box:rotate(-90)
	box:scale(1,1.1)
	box.y = gv.height/2
	box.x = gv.width/2 - 60
	
	
	group:insert(box)
	
	
	 --makes left arrow button
    local left = widget.newButton{
    
      x = gv.width/2,
      y =gv.height/2 + 210,
      defaultFile = "rightarrow.png",
      onEvent = prev,
    }
    left:rotate(90)
    left:scale(0.5,0.5)
   	group:insert(left)
   	
   	
   	--makes right arrow button
    local right = widget.newButton{
    
      x = gv.width/2,
      y =gv.height/2  - 210,
      defaultFile = "rightarrow.png",
      onEvent = next,
      
    }
    right:rotate(-90)
    right:scale(0.5,0.5)
    group:insert(right)
    
    displaySkin()
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