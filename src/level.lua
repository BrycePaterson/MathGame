local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gv = require("global")
local level = {}  --array used to hold level grid
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local function home(event)
  storyboard.gotoScene("menu")
end


local function handleButton(event)
	
	local s = event.target
	s = s:getLabel()
	
    if s=="1" then 
    	gv.hit = 0.3
    	gv.range = 10
		gv.level = 1
	elseif s == "2" then 
		gv.hit = 0.5
    	gv.range = 10
		gv.level = 2
	elseif s == "3" then 
		gv.hit = 0.5
    	gv.range = 20
		gv.level = 3
	elseif s == "4" then 
		gv.hit = 0.6
    	gv.range = 20
		gv.level = 4
	elseif s == "5" then 
		gv.hit = 0.6
		gv.range = 30
		gv.level = 5
	elseif s == "6" then 
		gv.hit = 0.7
    	gv.range = 30
		gv.level = 6
	elseif s == "7" then 
		gv.hit = 0.7
		gv.range = 40
		gv.level = 7
	elseif s == "8" then 
		gv.hit = 0.8
    	gv.range = 40
		gv.level = 8
    elseif s == "9" then 
		gv.hit = 0.8
    	gv.range = 50
		gv.level = 9
	end
    
	storyboard.gotoScene("arena")
end

--This is called automattically when Scene is called
function scene:createScene( event )
	group = self.view
	gv.section = 0
	
	background(group)

    local dx = 100
    local dy = 100

    local group = self.view
    --used to created level grid
    for i = 0, 2 do --row
        level[i] = {}
        for j = 0, 2 do --column
         
          local l = (j+1)*3-i
          
          if l > gv.progress[0] then
          --buttons can not be pressed
            level[i][j] = widget.newButton{
              label = (j+1)*3-i,
                x = dx*j + 200,
                y = dy*i + 325,
                fontSize = 20,
                width = 80,
                height = 80,
                defaultFile = "square.png",
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
                onEvent = handleButton
          }
            level[i][j]:setEnabled(false)
            
          else
              --buttons can be pressed
              level[i][j] = widget.newButton{
              label = (j+1)*3-i,
              x = dx*j + 200,
              y = dy*i + 325,
              fontSize = 20,
              width = 80,
              height = 80,
              defaultFile = "square.png",
              labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
              onEvent = handleButton
          }
                            
          end 
         
          level[i][j]:rotate(-90)                    
          group:insert(level[i][j])
        end  
    end
    
    --used to display what kind of level you are going to play
    local type = display.newText("Addition",200,100,"Georgia",50)
    type:setTextColor(200,200,200)
    type:rotate(-90)
    type.x = 50
    type.y = gv.height/2
    group:insert(type)
	local description = display.newText("Pick a Difficulty Level",225,100, "Georgia", 25)
	description.x = 100
	description.y = gv.height/2
	description:rotate(-90)
	group:insert(description)
   
    --makes home button
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
  storyboard.removeScene(level)
 
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