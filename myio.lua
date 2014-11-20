
local fileIO = {};

function fileIO:read( params )--参数 filename,object。如果object为空，则直接返回读出的字符串，如果不为空，则调用object的write方法填充object
	local filename = params.filename;
	local path = system.pathForFile( filename , system.DocumentsDirectory )
	local fileHandle , errorString = io.open(path , "r+")
	if errorString ~= nil then 
		print("io error "..errorString);
		return;
	end
	local context = fileHandle:read("*a");
	io.close(fileHandle);
	if params.object ~= nil then
		params.object:write(context);
	else
		return context;
	end
end

function fileIO:write( params )
	local filename = params.filename;
	local path = system.pathForFile( filename , system.DocumentsDirectory )
	local fileHandle = io.open(path , "wb")
	
	local object = params.object;
	local context = object:read();
	if context == nil then
		context = params.context;
	end
	--print("context to write is : "..context);
	fileHandle:write(context);
	fileHandle:close();


end

 

return fileIO;