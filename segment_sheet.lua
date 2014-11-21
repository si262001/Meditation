--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:f003b5ba3992fb2848f1c6d2cb069612:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- divide
            x=1288,
            y=2,
            width=3,
            height=60,

        },
        {
            -- segment
            x=700,
            y=2,
            width=20,
            height=60,

        },
        {
            -- segment_select
            x=100,
            y=2,
            width=20,
            height=60,

        },
    },
    
    sheetContentWidth = 1293,
    sheetContentHeight = 204
}

SheetInfo.frameIndex =
{

    ["divide"] = 1,
    ["segment"] = 2,
    ["segment_select"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
