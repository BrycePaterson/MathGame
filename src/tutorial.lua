local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local gv = require("global")
local widget = require("widget")

 
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
local t = 0
local time = 0
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
local function write()

  local path = system.pathForFile("tutTime.txt",system.DocumentsDirectory)
  local file = io.open(path, "a")
  
  file:write(gv.time.."\n")
  io.close(file)
  file = nil

end


local function home(event)
 
  --time = os.difftime(os.time(), time)
  t2 = os.date('*t')
  t3 = os.time(t2)
  
  gv.time = t3 - time
  
    write()
  --local text = display.newText(time,200,500,"Georgia",50)
  --text:setTextColor(200,200,200)
  --text:rotate(-90)
  
  storyboard.gotoScene("menu")
end


--This is called automattically when Scene is called
function scene:createScene( event )
  t = os.date('*t')
  time = os.time(t)
  
  local group = self.view
  	local tut = display.newImage("tutorial-page.png")
	  tut.x = gv.width/2
	  tut.y = gv.height/2
	 tut:scale(1.0,1.25)
	group:insert(tut)
	
	
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
  
  
  --next button
  local next = widget.newButton{
  x = gv.width - 50,
  y = 80,
  defaultFile = "Next.png",
  onEvent = next,
  }
  
  next:rotate(-90)
  next:scale(0.5,0.5)
  group:insert(next)
  
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