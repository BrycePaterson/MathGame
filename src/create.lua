local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require("widget")
local gv = require("global")
local level = {}  --array used to hold level grid
local extra = {}
local Op = {} --array used to hold operators
local confirm
local deny
-- Clear previous scene
storyboard.removeAll()
local group
 
-- local forward references should go here --
local num1 = ""
local num2 = ""
local operator = ""
local question = ""
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local function home(event)
  storyboard.removeScene("create")
  storyboard.gotoScene("menu")
end

--add operator buttons
local function addOp()
	for i = 0, 3 do
		Op[i].isVisible = true
	end
end

--clear operator buttons
local function clearOp()
	for i = 0, 3 do
		Op[i].isVisible = false
	end
end

--add confirm/clear buttons
local function addConfirm()
	confirm.isVisible = true
	deny.isVisible = true
end

--clear confirm/clear buttons
local function clearConfirm()
	confirm.isVisible = false
	deny.isVisible = false
end

--clear Calculator
local function removeCalc()
	for i = 0, 2 do --row
        for j = 0, 2 do --column
        	level[i][j].isVisible = false
        end
        extra[i].isVisible = false
    end
end

--add calculator
local function addCalc()
	
		for i = 0, 2 do --row
			for j = 0, 2 do --column
				level[i][j].isVisible = true
			end
			extra[i].isVisible = true
		end
end

--add num1 to question
local function number1(event)
	local s = event.target
	s = s:getLabel()
	num1 = num1..s
	question = question..s
end

--add num2 to question
local function number2(event)
	local s = event.target
	s = s:getLabel()
	num2 = num2..s
	question = question..s
end

--add to question
local function add(event)
	if event.phase == "began" then
		if operator =="" then
			number1(event)
			q.text=question
		else
			number2(event)
			q.text=question
		end
	end
end

--clear question
local function clearQ()
	num1 = ""
	num2 = ""
	operator = ""
	question = ""
	q.text = ""
	clearConfirm()
	addCalc()
end

--add the question to the file
local function makeQ()
	clearQ()
end

--calculator event handler
local function input(event)
	
	local s = event.target
	s = s:getLabel()

    if s=="1" then 
		add(event)
	elseif s == "2" then 
		add(event)
	elseif s == "3" then 
		add(event)
	elseif s == "4" then 
		add(event)
	elseif s == "5" then 
		add(event)
	elseif s == "6" then 
		add(event)
	elseif s == "7" then 
		add(event)
	elseif s == "8" then 
		add(event)
    elseif s == "9" then 
		add(event)
	elseif s == "0" then
		add(event)
	end
end

--clear current number
local function clear(event)
	if event.phase == "began" then
		if operator == "" then
			num1 = ""
			question = ""
			q.text = question
		else 
			num2 = ""
			question = num1..operator
			q.text = question
		end
	end
end


--enter event handler
 local function enter(event)
	if event.phase == "began" then
		if operator=="" then
			removeCalc()
			addOp()
		else
			removeCalc()
			addConfirm()
		end
	end
end

--handle operator buttons
local function op(event)
	if event.phase == "began" then
		local s = event.target
		s = s:getLabel()
		if s=="x" then 
			s="*"
		elseif s=="%" then
			s="/"
		end
		operator = s
		question = question..operator
		q.text = question
		clearOp()
		addCalc()
	end
end

--make confirm/deny buttons
local function makeConfirm()
	local dx = 100
    local dy = 100

	confirm = widget.newButton{
				label = "CONFIRM",
                x = dx + 125,
                y = dy + 325,
                fontSize = 20,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = makeQ
			}
	confirm:rotate(-90)
	group:insert(confirm)
	
	deny = widget.newButton{
				label = "clear",
                x = dx + 125,
                y = 325,
                fontSize = 20,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = clearQ
			}
	deny:rotate(-90)
	group:insert(deny)
end

--make operator buttons
local function makeOp()
	local dx = 100
    local dy = 100

	Op[0] = widget.newButton{
				label = "+",
                x = dx + 125,
                y = 325,
                fontSize = 40,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = op
			}
	Op[0]:rotate(-90)
	group:insert(Op[0])
	
	Op[1] = widget.newButton{
				label = "-",
                x = dx + 125,
                y = dy + 325,
                fontSize = 40,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = op
			}
	Op[1]:rotate(-90)
	group:insert(Op[1])
	
	Op[2] = widget.newButton{
				label = "x",
                x = dx + 125,
                y = dy*2 + 325,
                fontSize = 40,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = op
			}
	Op[2]:rotate(-90)
	group:insert(Op[2])
	
	Op[3] = widget.newButton{
				label = "%",
                x = dx + 125,
                y = dy*3 + 325,
                fontSize = 40,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = op
			}
	Op[3]:rotate(-90)
	group:insert(Op[3])
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
                fontSize = 40,
                width = 80,
                height = 80,
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
                fontSize = 30,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = clear
          }
	extra[0]:rotate(-90)
	group:insert(extra[0])
	
	extra[1] = widget.newButton{
            	label = "0",
                x = 425,
                y = 425,
                fontSize = 40,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = input
          }
	extra[1]:rotate(-90)
	group:insert(extra[1])
	
	extra[2] = widget.newButton{
            	label = "ENTER",
                x = 425,
                y = 325,
                fontSize = 30,
                width = 80,
                height = 80,
                labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
				onEvent = enter
          }
	extra[2]:rotate(-90)
	group:insert(extra[2])
end

--This is called automattically when Scene is called
function scene:createScene( event )
	group = self.view

	background(group)
	local box = display.newImage("questionbox.png")
	box:rotate(-90)
	box:scale(1,1)
	box.y = gv.height/2
	box.xScale = 0.7
	
	q = display.newText(question,35,gv.height/2,"Georgia",50)
	q:rotate(-90)
	q:setTextColor(0,0,0)
	
	group:insert(box)
	group:insert(q)
    local group = self.view
    --used to created level grid
	makeOp()
	clearOp()
	makeConfirm()
	clearConfirm()
    makeCalc()

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