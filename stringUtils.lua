


local stringUtils = {};

function stringUtils:split( sourceString , split )
	local t = {};
	local index = string.find(sourceString,split);

	if index ~= nil then
		local subString = string.sub(sourceString,1,index - 1);
		sourceString = string.sub(sourceString,index + 1);
		while subString ~= nil do 
			table.insert(t,subString);
			index = string.find(sourceString,split);
			if index == nil then 
				if sourceString ~= nil then
					table.insert(t,sourceString);
					break
				end
			end
			subString = string.sub(sourceString,1,index - 1);
			sourceString = string.sub(sourceString,index + 1);
		end
	end
	return t;
end

return stringUtils;

