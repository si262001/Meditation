local deviceHeight = display.pixelHeight / 2;
local deviceWidth  = display.pixelWidth  / 2;
local widget = require( "widget" )
local composer = require( "composer" )
local scene = composer.newScene()

-- Our scene
function scene:create( event )
	local sceneGroup = self.view
	
	-- Display a background
	local background = display.newImage( "assets/background.png", display.contentCenterX, display.contentCenterY, true )
	sceneGroup:insert( background )
	
	-- Status text box
	local statusBox = display.newRect( 50, 60, 210, 80 )
	statusBox.anchorX = 0
	statusBox.anchorY = 0
	statusBox:setFillColor( 0, 0, 0 )
	statusBox.alpha = 0.4
	sceneGroup:insert( statusBox )
	
	-- Status text
	local statusText = display.newText( "", 80, 350, 200, 0, native.systemFont, 32 )
	statusText.anchorX = 0
	statusText.anchorY = 0
	statusText.x = statusBox.x + 5
	statusText.y = statusBox.y + 5
	sceneGroup:insert( statusText )
	
	---------------------------------------------------------------------------------------------
	-- widget.newPickerWheel()
	---------------------------------------------------------------------------------------------
	
	local shi = {}
	local ge = {}
	
	for i = 1, 10 do
		shi[i] = i - 1;
		ge[i] = i - 1;
	end
	
	
	-- Set up the Picker Wheel's columns
	local columnData = 
	{ 
		
		
		{
			align = "center",
			width = 120,
			startIndex = 1,
			labels = shi,
		},
		{
			align = "center",
			width = 120,
			startIndex = 1,
			labels = ge,
		},
	}
		
	-- Create a new Picker Wheel
	local pickerWheel = widget.newPickerWheel
	{
		top = 210,
		font = native.systemFontBold,
		columns = columnData,
	    overlayFrameWidth = 320,
	    overlayFrameHeight = 222,
	    backgroundFrame = 2,
	    backgroundFrameWidth = 320,
	    backgroundFrameHeight = 222,
	    separatorFrame = 3,
	    separatorFrameWidth = 8,
	    separatorFrameHeight = 222,
	}
	sceneGroup:insert( pickerWheel )
	
	
	local timerId;
	local function startTimer( event )
		local values = pickerWheel:getValues()

		local shifen = tonumber(values[1].value);
		local gefen  = tonumber(values[2].value);
		local miao = 0;
		if shifen > 0 then
			miao = shifen * 10 * 60;
		end
		if gefen > 0 then
			miao = gefen * 60 + miao;
		end
		if miao > 0 then
			if timerId ~= nil then
				timer.cancel(timerId);
				timerId = nil;
			end 
			timerId = timer.performWithDelay(1000,function ( ... )
				statusText.text = miao;
				miao = miao - 1; 
				if miao == 10 then
					local event = { name = "timerending" };--还有10秒结束的时候，发出timerending事件。目前接收方是音频slider，它们会在10秒内淡出音频并停止
					Runtime:dispatchEvent(event);
				end
			end,miao + 1)
		end
		
		return true
	end
	
	
	local getValuesButton = widget.newButton
	{
	    left = 10,
	    top = 150,
		width = 298,
		height = 56,
		id = "timer",
	    label = "开始",
	    onRelease = startTimer,
	}
	sceneGroup:insert( getValuesButton )

	function stopTimer( )
		if timerId ~= nil then
			timer.cancel(timerId);
			timerId = nil;
			statusText.text = "";
		end
	end

	Runtime:addEventListener("slidermoved",stopTimer);--slider滑动后，停止定时器
end

scene:addEventListener( "create" )

return scene
