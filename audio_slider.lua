module(..., package.seeall)

local widget = require( "widget" );
function newSlider( params )

-- Image sheet options and declaration
-- local options = {
--     frames = {
--         { x=0, y=0, width=36, height=64 },
--         { x=40, y=0, width=36, height=64 },
--         { x=80, y=0, width=36, height=64 },
--         { x=124, y=0, width=36, height=64 },
--         { x=168, y=0, width=64, height=64 }
--     },
--     sheetContentWidth = 232,
--     sheetContentHeight = 64
-- }
-- local sliderSheet = graphics.newImageSheet( "sliderSheet.png", options );

-- channel用来区分各个音效
local mymp3 = audio.loadStream( params.mymp3 );
if mymp3 ~= nil then
audio.play(mymp3,{ channel = params.channel, loops = -1});
audio.pause(params.channel);
audio.setVolume(0,{channel=params.channel});
end
local slider;

-- 滑动滑块，对应音效声音大小变化，如果滑块滑到0，音效暂停
local function sliderListener( event )
    if mymp3 ~= nil then
        if event.value > 0 then
            slider.volume = event.value / 100;
            slider:play(slider.volume);
        else
            slider:pause();
        end
    end
    if event.phase == "ended" then
        local event = {name="slidermoved"};--发出slider移动的事件。接收方目前是定时器，silder移动后，定时器停止
        Runtime:dispatchEvent(event);
    end
end

-- Create the widget
slider = widget.newSlider
{
    
    top = params.top,
    left= params.left,
    width = params.width,
    value = params.value,
    listener = sliderListener
}
slider.mp3Name = params.mp3Name;
slider.mp3 = mymp3;
slider.mp3channel = params.channel;
slider.mp3Key = params.mp3Key;
slider.volume=0;
local title = display.newText( params.mp3Name, slider.x, slider.y, native.systemFont, 14 )
slider.title = title;
title:setFillColor( 1, 1, 1 )

function slider:play(num)
    if num == nil and slider.volume == 0 then
        slider.volume = 0.2;
    end
    
    audio.setVolume(slider.volume,{channel=params.channel});
    slider:setValue(slider.volume * 100);
    if audio.isChannelPlaying(params.channel) then
        return
    else
        audio.resume(params.channel);
    end
end

function slider:isPlaying() 
    return audio.isChannelPlaying(params.channel);
end

function slider:pause( )
    audio.pause(params.channel);
    slider:setValue(0);
end


function slider:moveTo( x )
    transition.to( slider , {
        time = 400 , x = x , easing=outQuart
        })

    transition.to( title , {
        time = 400 , x = slider.width / 2 + x + title.width / 2, easing=outQuart
        })
end

function slider:setPosition( x,y )
    if x ~= nil then
        slider.x = x;
        title.x = x;
    end
    if y ~= nil then
        slider.y = y;
        title.y = y;
    end
end

function slider:setVolume( num )
    slider.volume = num;
    audio.setVolume(slider.volume,{channel=params.channel});
end


return slider;

end