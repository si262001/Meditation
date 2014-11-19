local deviceHeight = display.pixelHeight / 2;
local deviceWidth  = display.pixelWidth  / 2;


local widget = require( "widget" )
local composer = require( "composer" )
local mapBuilder = require("hashmap");
local audioSlider = require("audio_slider");
local scene = composer.newScene()

local LEFT_PADDING = 10;

local scene2audio = mapBuilder:newMap();--分类场景对应的MP3
local category2audio = mapBuilder:newMap();--类型对应的mp3
local scenes = {"quiet","beach","forest","customer"}--分类场景名称
local audioCategory = { "WEATHER", "WATER", "BIRD", "INSECT", "TEMPLE" };--音效分类
--分好类的MP3文件
local weather = {"rain2","thunder","wind"};
local water = {"dida","river","sea"};
local bird = {"bird_big","bird1","bird2","bird3","seagull"};
local insect = {"bug_ok","frog"};
local temple = {"bell","boat"}

--所有的MP3 slider数组
local sliderMap = mapBuilder:newMap();



function initMp3( params )
	local sceneGroup = params.sceneGroup;
	function initMp3WithName(name)
		local channel = sliderMap:size() + 1;
		local mSlider = audioSlider.newSlider{
			mymp3="mp3/"..name..".mp3",
			channel = channel,
			top = -200,
			left = 20,
			width = 200,
			value = 0,
			mp3Name=name
		}
		if(sceneGroup ~= nil) then
			sceneGroup:insert(mSlider);
			sceneGroup:insert(mSlider.title);
		end
		sliderMap:put(name,mSlider);
		return mSlider;
	end
	function initMp3WithArray(catName,array)
		local mp3Arr = {};
		for i=1,table.maxn(array) do
			table.insert(mp3Arr,initMp3WithName(array[i]));
		end
		category2audio:put(catName, mp3Arr);
	end

	initMp3WithArray(audioCategory[1],weather);
	initMp3WithArray(audioCategory[2],water);
	initMp3WithArray(audioCategory[3],bird);
	initMp3WithArray(audioCategory[4],insect);
	initMp3WithArray(audioCategory[5],temple);

	scene2audio:put("beach",{sliderMap:get("seagull"),sliderMap:get("sea"),sliderMap:get("boat")})
	scene2audio:put("forest",{sliderMap:get("bird1"),sliderMap:get("river"),sliderMap:get("bird3"),sliderMap:get("wind")})
	scene2audio:put("customer",{sliderMap:get("bell"),sliderMap:get("rain2"),sliderMap:get("bird2")})
end





function scene:create( event )
	local sceneGroup = self.view;
	local onStageSliders = {};
	local tableView = nil
	initMp3{sceneGroup = sceneGroup};


	local function segmentedControlListener( event )
		local target = event.target
		local name = target.segmentLabel;
		local sliders = scene2audio:get(name);
		if sliders ~= nil then
			for i=1,table.maxn(sliderMap:getKeys()) do
				local oneSlider = sliderMap:get((sliderMap:getKeys())[i]);
				oneSlider:pause()
			end
			for i=1,table.maxn(sliders) do
				sliders[i]:play(0.5);
			end
			
		else
			for i=1,table.maxn(sliderMap:getKeys()) do
				local oneSlider = sliderMap:get((sliderMap:getKeys())[i]);
				oneSlider:pause()
			end
		end

		local event = { name="refreshRow" }--选了segment后，对应的音频改变，所以要刷新row
		Runtime:dispatchEvent( event )

		
		
	end

	local segmentedControl = widget.newSegmentedControl
	{
	    left = 10,
	    top = 10,
	    segments = scenes,
	    defaultSegment = 1,
	    onPress = segmentedControlListener,
	    segmentWidth = 300 / table.maxn(scenes)
	}
	sceneGroup:insert( segmentedControl )


	-- Back button
	function goBack( )
		for i=1,table.maxn(onStageSliders) do
			local oneSlider = onStageSliders[i];
			oneSlider:moveTo(450);
		end
		transition.to(
				tableView,{time = 400 , x = 160, easing=outQuart}
			)
		transition.to(
				segmentedControl,{time = 400, x = 160,easing=outQuart}
			)
		local event = { name="refreshRow" }--音频更改之后，发出刷新row的事件
		Runtime:dispatchEvent( event )
	end

	local backButton = widget.newButton
	{
		width = 198,
		height = 59,
		label = "Back",
		onRelease = goBack,
	}
	backButton.x = display.contentWidth + backButton.contentWidth
	backButton.y = 350;
	sceneGroup:insert( backButton )


	
	local function tableViewListener( event )
		local phase = event.phase
		
	end

	local function onRowRender( event )
		local phase = event.phase
		local row = event.row
		

		local groupContentHeight = row.contentHeight

		local rowTitle = display.newText( row, row.params.name, 0, 0, nil, 14 )
		local title;
		Runtime:addEventListener("refreshRow" , function( )--把正在播放的mp3的名字，显示到row上
			local sliders = category2audio:get(row.params.name);

			title = row.params.name.."      ";
			for i=1,table.maxn(sliders) do
				if sliders[i]:isPlaying() then
					title = title..sliders[i].mp3Name..".";
				end
			end
			rowTitle.text = title;
		end)

		rowTitle.x = LEFT_PADDING

		rowTitle.anchorX = 0

		rowTitle.y = groupContentHeight * 0.5
		rowTitle:setFillColor( 0, 0, 0 )
	end
	
	local function onRowUpdate( event )
		local phase = event.phase
		local row = event.row
		
	end
	
	local function onRowTouch( event )
		local phase = event.phase
		local row = event.target
		if phase == "tap" then
			local sliders = category2audio:get(row.params.name);

			onStageSliders = sliders;
			for i=1,table.maxn(sliders) do

				local oneSlider = sliders[i];
				oneSlider:setPosition(400, 50 + i * 45);
				oneSlider:moveTo(150)
			end
			transition.to(
					tableView, {time = 400, x = -200,easing=outQuart}
				)
			transition.to(
					segmentedControl, {time = 400, x = -200,easing=outQuart}
				)
			transition.to(
					backButton, {time = 400, x = 160, easing = outQuart}
				)
		end

		
	end
	
	tableView = widget.newTableView
	{
		top = 132,
		width = 320, 
		height = 300,
		listener = tableViewListener,
		onRowRender = onRowRender,
		onRowUpdate = onRowUpdate,
		onRowTouch = onRowTouch,
	}
	sceneGroup:insert( tableView )

	local size = table.maxn(audioCategory);
	
	for i = 1, size do
		local isCategory = false
		local rowHeight = 40
		local rowColor = 
		{ 
			default = { 1, 1, 1 },
			over = { 30/255, 144/255, 1 },
		}
		local lineColor = { 220/255, 220/255, 220/255 }
		
		if i == 25 or i == 50 or i == 75 then
			isCategory = true
			rowHeight = 24
			rowColor = 
			{ 
				default = { 150/255, 160/255, 180/255, 200/255 },
			}
		end
		
		tableView:insertRow
		{
			isCategory = isCategory,
			rowHeight = rowHeight,
			rowColor = rowColor,
			lineColor = lineColor,
			params={name=audioCategory[i]}
		}
	end

	function fadeOutAudio( )
		audio.fadeOut({channel=0,time=10000});--10秒淡出音频，因为定时器是结束前10秒发出的timerending事件
		timer.performWithDelay(10000,function(  )--10秒后把slider的滑块状态置为0
			for i=1,table.maxn(sliderMap:getKeys()) do
				local oneSlider = sliderMap:get((sliderMap:getKeys())[i]);
				oneSlider:pause()
			end
			local event = { name="refreshRow" }--因为音频已经停止，所以发出刷新row的事件,把row中显示的正在播放的音频清空
			Runtime:dispatchEvent( event )
			segmentedControl:setActiveSegment(1);--选择跳到quiet去
		end)
	end

	Runtime:addEventListener("timerending", fadeOutAudio);--监听定时器快到的事件
end

function  scene:show( event )
	
	
end



scene:addEventListener( "create" )
scene:addEventListener( "show" )


return scene
