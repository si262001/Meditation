

local mapConstructor = {};

function mapConstructor:newMap()
	local map = {};
	local keys = {};

	function map:put(key,value)
		map[key] = value;
		table.insert(keys,key);
	end

	function map:get(key)
		return map[key];
	end

	function map:getKeys()
		return keys;
	end

	function map:size()
		return table.maxn(keys);
	end

	return map;
end

return mapConstructor;