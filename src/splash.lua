local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local gv = require("global")
gv.height = display.contentHeight
gv.width = display.contentWidth
local time_path = system.pathForFile("total_time.txt",system.DocumentsDirectory)
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


--This is called automattically when Scene is called
function scene:createScene( event )
  local group = self.view
  gv.time = 0
  gv.equip = 3
  gv.skinlist[0] = "Good_Guy_b_complete.png"
  gv.skinlist[1] = "Good_Guy_g_complete.png"
  gv.skinlist[2] = "Good_Guy_s_complete.png"
  gv.skinlist[3] = "Good_Guy.png"
  gv.currentskin = gv.skinlist[3]
  
  local total_time = io.open(time_path, "r")
  if(total_time==nil)then
	gv.totalTime = 0
	local total_time_write = io.open(time_path, "w")
	total_time_write:write(gv.totalTime)
	io.close(total_time_write)
	total_time_write = nil
  else
	gv.totalTime = total_time:read("*n")
  end
  local start = os.date('*t')
  gv.start_time = os.time(start)
  total_time = nil
  gv.section = 0
  
  local music = audio.loadStream("Math_Gladiator_Music.mp3")
  audio.play(music,{ loops = -1 })
  
  background(group)
    
  --makes game tile to be shown
 local title = display.newImage("Gladiator-Title-Altered.png")
	title.x = 200
	title.y = 400
	--title:scale(2.0,2.0)
	group:insert(title)
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