-- Location where writen files are stored
-- C:\Users\raffi\AppData\Roaming\Corona Labs\Corona Simulator\Sandbox\src-084303B6A77F97E6E874C1BE5E5205B1\Documents

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gv = require("global")
local time_path = system.pathForFile("total_time.txt",system.DocumentsDirectory)
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
--------------------------------------------------------------------------------- 
 
local function play(event)

  storyboard.gotoScene("level")

end 

local function localstore(event)

	gv.store = true
	storyboard.gotoScene("localstore")
end
 
 local function about(event)
 
    storyboard.gotoScene("about")
 end
 
 local function tutorial(event)
  
  storyboard.gotoScene("tutorial")
  
   --local text = display.newText(display.contentHeight,200,100,"Georgia",50)
   --text:setTextColor(200,200,200)
end

local function customQuestion(event)
	storyboard.gotoScene("create")
end

local function exit(event)
	local stop = os.date('*t')
	local stop_time = os.time(stop)
	local time_played = stop_time - gv.start_time
	gv.totalTime = gv.totalTime + time_played
	local totalTime_write = io.open(time_path, "w+")
	totalTime_write:write(gv.totalTime)
	io.close(totalTime_write)
	totalTime_write = nil
	audio.stop()
    os.exit()
end

local function readFile()

	local path = system.pathForFile("first2.txt",system.DocumentsDirectory)
	local file = io.open(path, "r")
	local data = file:read("*a")
	
	if data == "yes" then 
		gv.permission = 1
	else
		gv.permission = 0
	end
end

local function writeFirst(event)

	local i = event.index
	local path = system.pathForFile("first2.txt",system.DocumentsDirectory)
	local file = io.open(path, "w+")
	if i == 1	then
		file:write("yes","\n")
		gv.permission = 1
	elseif 1 == 2 then
		file:write("no","\n")
		gv.permission = 0
	end
	
	io.close(file)
	file = nil
end

--writes the progress file for progress in each game section
local function writeProgress()

  local path = system.pathForFile("progress.txt",system.DocumentsDirectory)
  local file = io.open(path, "w+")
  
  for x = 0, 3 do
    file:write("1 \n")
  end
  
  io.close(file)
  file = nil
  
end


local function loadProgress()  --holds how far the user has gotten in each operation
  
  local path = system.pathForFile("progress.txt",system.DocumentsDirectory)
  local file = io.open(path, "r")
  
  gv.progress = {}
  for x = 0, 3 do
      local data = file:read("*n")
      gv.progress[x] = data
  end
  
  io.close(file)
  file = nil
  
end

local function writeDate()

	local path = system.pathForFile("date.txt",system.DocumentsDirectory)
  	local file = io.open(path, "w+")
  	
  	file:write(os.date("%c"))
  	
  	io.close(file)
  	
  	file = nil

end

local function firstTime()

	local path = system.pathForFile("first2.txt",system.DocumentsDirectory)
	local file = io.open(path, "r")
	
	if(file==nil)then
	  writeMoney(true)
	  loadMoney()
	  writeProgress()
	  loadProgress()
	  writeDate()
	local alert = native.showAlert( "Hey There","Can we learn more about our game from your experience", { "Yes", "No" }, writeFirst )
	else
	 
		loadMoney()
		readFile()
		loadProgress()
	end
	file = nil
	
end
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
   
    background(group)
  
  	--loads play image
 	  local pl = display.newImage("PLAY.png")
    pl.isVisible = false
	  local play = widget.newButton{
        x = pl.contentHeight,
        y = gv.height - (pl.contentWidth/2),
	      defaultFile = "PLAY.png",
	      onEvent = play, 
    }
    play:rotate(-90)
	  group:insert(play)
	
	  --loads tutorial image
 	  local tutorial = widget.newButton{
   	    x = gv.width/2,
   	    y = gv.height/2,
   	    defaultFile = "TUTORIAL.png",
   	    onEvent = tutorial,
 	  }
 	  tutorial:rotate(-90)
 	  group:insert(tutorial)
 	
 	
 	  --loads exit button
 	  local quit = display.newImage("EXIT.png")
 	  quit.isVisible = false
 	  local exit = widget.newButton{
   	    x = gv.width - quit.contentHeight/2,
   	    y = quit.contentWidth/3,
   	    defaultFile = "EXIT.png",
   	    onEvent = exit,
  	}
 	
    exit:rotate(-90)
    group:insert(exit)
    
     --loads about button
    local ab = display.newImage("About.png")
    ab.isVisible = false
    local about = widget.newButton{
        x = gv.width - ab.contentHeight/2,
        y = gv.height - 200,
        defaultFile = "About.png",
        onEvent = about,
    }
  
    about:rotate(-90)
    group:insert(about)
    
    
    --loads Store button
    local st = display.newImage("Store.png")
    st.isVisible = false
    local store = widget.newButton{
        x = st.contentHeight,
        y = st.contentHeight + 100,
        defaultFile = "Store.png",
        onEvent = localstore,
    }
    
    store:rotate(-90)
    group:insert(store)
	
	--load custom questions button
	local cu = display.newImage("Custom.png")
	cu.isVisible = false
	local custom = widget.newButton{
        x = gv.width/2 + 100,
   	    y = gv.height/2,
        defaultFile = "Custom.png",
        onEvent = customQuestion,
    }
	custom.xScale = 0.7
	custom.yScale = 0.7
    
    custom:rotate(-90)
    group:insert(custom)
    
    firstTime()
    
    --local text = display.newText(gv.progress[0],200,500,"Georgia",50)
    --text:setTextColor(200,200,200)
    --text:rotate(-90)
 
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