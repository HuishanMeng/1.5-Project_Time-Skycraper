
display.setStatusBar(display.HiddenStatusBar)
local date=os.date("*t")
	local h=date.hour
	local m=date.min
	local s=date.sec
local myMoon=display.newImage("moon.png")
myMoon.x=350
 myMoon.y=280	
 local myTime="Time"..":"..h..":"..m..":"..s
local inText=display.newText(myTime,350,100,"Comic Sans MS",30)	
local hint=display.newText("Shake to destroy buidlings",590,20,"Comic Sans MS",20)
	inText: setFillColor( 153/255,12/255,232/255 )
	hint:  setFillColor( 1,1,1 )
local physics  = require ("physics")
physics.start()
function setWindow(buiX, buiY,buiWidth,buiHeight,rn,fn,d,color,v)

	local value=v
	
    local time=d
	local buildingX=buiX
	local buildingY=buiY
	local buildingLayers= display.newGroup( )  ---important
    local buildingWidth=buiWidth
    local buildingHeight=buiHeight 
    local floorNumber=fn
    local roomNumber=rn

    local windowWidthToRoomWidth = 1 / 2
	local windowHeightToRoomHeight = 1 / 2 
    local roomWidth = math.round( buildingWidth / roomNumber )
	local roomHeight = math.round( buildingHeight / floorNumber )
	local windowWidth = math.round( roomWidth * windowWidthToRoomWidth)
	local windowHeight = math.round( roomHeight * windowHeightToRoomHeight)
	local roomCenterX = roomWidth * 0.5
	local roomCenterY = roomHeight * 0.5
	local remainderX = buildingWidth - ( roomWidth * roomNumber )
	local remainderY = buildingHeight - ( roomHeight * floorNumber )

	local windowCenterX = windowWidth * 0.5
	local windowCenterY = windowHeight * 0.5 
	local winAnchorX = remainderX - roomCenterX
	local winAnchorY = remainderY - roomCenterY

	local windowLights = color 

	local buildingColor = { 0.3, 0.3, 0.3 } 

	local buiAdjustX = buildingX + ( buildingWidth * 0.5 ) 

	local winAdjustX = buildingX + winAnchorX

	local buiAdjustY = buildingY - ( buildingHeight * 0.5 )

	local winAdjustY = buildingY + winAnchorY - buildingHeight

	local building = display.newRect( buiAdjustX, buiAdjustY, buildingWidth, buildingHeight )
	building.fill = buildingColor

buildingLayers:insert(building) 

	if time % roomNumber==0 then
	for row= 1, math.floor(time/roomNumber) do
		for column = 1, roomNumber do
			local x = winAdjustX + (column * roomWidth) 
			local y = winAdjustY + (row * roomHeight) 
			local window = display.newRect (x, y, windowWidth, windowHeight)
			window.fill = windowLights
			buildingLayers:insert(window)
end
		end

	end
if time % roomNumber ~= 0 then
 	
		for row = 1, math.floor(time/roomNumber) do
			for column = 1, roomNumber do
			local x = winAdjustX + (column * roomWidth) 
			local y = winAdjustY + (row * roomHeight) 
			local window = display.newRect (x, y, windowWidth, windowHeight)
			window.fill = windowLights
			buildingLayers:insert(window)
end
		end

	for row =1, math.floor(time/roomNumber)+1 do 
		for column = 1, time %roomNumber do
			local x = winAdjustX + (column* roomWidth) 
			local y = winAdjustY + (row * roomHeight) 
			local newWindow = display.newRect (x, y, windowWidth, windowHeight)
			newWindow.fill = windowLights
			buildingLayers:insert(newWindow)
		end
	end
end
local function fallWindow()
	physics.setGravity(0,2)
    physics.addBody(buildingLayers,"dynamic",{density=0.2, friction=1,bouce=0.2, shape=6})
end
if value==1 then
	fallWindow()
	   timer.performWithDelay(3000, fallWindow,5)
end
return buildingLayers

end

local groundLevel = display.contentHeight * 1
local buildingOne = setWindow( 130, groundLevel, 100, 200,4, 6, h, { 0.1,0.8,0.2})
local buildingTwo = setWindow (250, groundLevel, 150,300,6,10,m,{1,0.8,0.2})
 local buildingThree = setWindow (420, groundLevel, 150,350,6,10,s,{ 240/255,130/255,12/255})
print(date.hour)


function onShake(event)
 if event.isShake then
buildingOne:removeSelf()
buildingOne = nil
local buildingOne = setWindow( 130, groundLevel, 100, 200,4, 6, h, { 0.1,0.8,0.2},1)
buildingTwo:removeSelf()
buildingTwo = nil
local buildingTwo = setWindow (250, groundLevel, 150,300,6,10,m,{1,0.8,0.2},1)
buildingThree:removeSelf()
buildingThree = nil
local buildingThree = setWindow (420, groundLevel, 150,350,6,10,s,{ 240/255,130/255,12/255},1)


	local sound=audio.loadSound("crash.mp3")
	local laserChannel = audio.play( sound )
end
end

 Runtime:addEventListener("accelerometer", onShake)
timer.performWithDelay( 1000, onShake )
