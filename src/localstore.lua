local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local gv = require("global")
local widget = require("widget")

local gimages ={}
local cost = {}
local current = 0
local group 
local box
local q
local money
local buy
local cloneOwned = {}
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local function home(event)
	storyboard.removeAll()
  storyboard.gotoScene("menu")
end

local function dispimage()

	gimages[current].x = 180
	gimages[current].y = gv.height/2
	gimages[current].isVisible = true
	group:insert(gimages[current])
	
	if gv.owned[current] == 0 then 
		q.text = "Owned"
		if current == gv.equip then
			buy:setLabel("Equiped")
		else
			buy:setLabel("Equip?")
		end
	else
		q.text = "Cost $"..cost[current]
		buy:setLabel("Purchase!")
	end

end

local function removeimage()

	gimages[current].isVisible = false

end

local function next(event)

	if event.phase == "began" then
	
		removeimage()
		
		if(current>= OP)then
			current =0
		else
		
			current = current+1
		end
		
		dispimage()
	end
end

local function prev(event)

	if event.phase == "began" then
		removeimage()
		
		if(current== 0)then
			current = OP
		else
		
			current = current-1
		end
		dispimage()
		 --text.text = current
		 --owned.text = gv.owned[current]
	end
end

local function loadimage()

	gimages[0] = display.newImage("Good_Guy_b_complete.png")
	gimages[1] = display.newImage("Good_Guy_g_complete.png")
	gimages[2] = display.newImage("Good_Guy_s_complete.png")
	gimages[3] = display.newImage("Good_Guy.png")
	
	cost[0] = 100
	cost[1] = 150
	cost[2] = 200
	cost[3] = 0
	
	for x = 0,OP do
		gimages[x].isVisible = false
		gimages[x]:rotate(-90)
	end

end

local function answer(event)

	local i = event.index

	if(i == 1) then
		--do nothing
	elseif(i == 2)then
		gv.gold = gv.gold - cost[current]
		gv.owned[current] = 0
		writeMoney(false)
		loadMoney()
		money.text = "$"..gv.gold
		q.text = "Owned"
		buy:setLabel("Equip?")
		--owned.text = gv.owned[current]
	end

end

local function purchase(event)
	if event.phase == "began" then
		
		if buy:getLabel()=="Equiped" then
		
		else
			if(buy:getLabel()=="Equip?")then
				gv.currentskin = gv.skinlist[current]				
				buy:setLabel("Equiped")
				gv.equip = current
			elseif gv.gold < cost[current] then 
				native.showAlert("Purchase","You can not afford this skin yet",{"Okay"}, answer)
			elseif(gv.owned[current] == 0) then
				native.showAlert("Purchase","You already own this skin",{"Okay"}, answer)
			else
				native.showAlert("Purchase","Are you sure you want to buy this skin",{"No","Yes"}, answer)
			end
		end
	end
end


--This is called automattically when Scene is called
function scene:createScene( event )
  group = self.view
  
  for i = 0, OP do
  	cloneOwned = gv.owned[i]
  end
  background(group)
  
  
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

	--makes card background
 	box = display.newImage("card.png")
	box:rotate(-90)
	box:scale(1,1.1)
	box.y = gv.height/2
	box.x = gv.width/2 - 60

	group:insert(box)
	
	--creates purchase button
	buy = widget.newButton{
    
      x = box.contentWidth + 50,
      y = gv.height - 150,
     defaultFile = "questionbox.png",
     label = "Purchase!",
 		fontSize = 80,
 		labelColor = { default = { 0, 0, 0 }, over = {0} },
      onEvent = purchase,
    }
    buy:rotate(-90)
    buy:scale(0.4,0.5)
   	group:insert(buy)
	
	loadimage()
	
	local c = display.newImage("questionbox.png")
	c:rotate(-90)
	c:scale(1,1)
	c.y = gv.height/2
	c.x = box.contentWidth + 50
	c.xScale = 0.5
	c.yScale = 0.5
	
	group:insert(c)
	
	q = display.newText("Cost $"..cost[current],c.x,c.y,"Georgia",50)
	q:rotate(-90)
	q:setTextColor(0,0,0)

	group:insert(q)
	
	gv.hold =box.contentWidth + 50
	
	local cc = display.newImage("questionbox.png")
	cc:rotate(-90)
	cc:scale(1,1)
	cc.y = gv.height/2 - 300
	cc.x = box.contentWidth + 50
	cc.xScale = 0.3
	cc.yScale = 0.5
 	
 	group:insert(cc)
 	
 	loadMoney()
 	money = display.newText("$"..gv.gold,c.x,gv.height/2 - 300,"Greorgia",50)
 	money:rotate(-90)
 	money:setTextColor(0,0,0)
 	
 	group:insert(money)
 	
 	
 	dispimage()
 	
 		--text = display.newText(current,200,500,"Georgia",50)
  		--text:setTextColor(200,200,200)
  		--text:rotate(-90)
  		
  		--owned = display.newText(gv.owned[current],300,500,"Georgia",50)
  		--owned:setTextColor(200,200,200)
  		--owned:rotate(-90)
 
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