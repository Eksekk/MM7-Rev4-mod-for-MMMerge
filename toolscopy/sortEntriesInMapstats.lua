-- below functions are taken from MMExtension repo, as they're not released yet and I don't feel like writing my own saving function, because I might screw something up

-- Saves a string into a file (overwrites it)
function io.save(path, s, translate)
	local f = assert(io.open(path, translate and "wt" or "wb"))
	f:setvbuf("no")
	f:write(s)
	f:close()
end

local path_noslash = _G.path.noslash
local path_dir = _G.path.dir
local CreateDirectoryPtr = internal.CreateDirectory

local function DoCreateDir(dir)
	-- 183 = already exists
	return mem.call(CreateDirectoryPtr, 0, dir, 0) ~= 0
end

local function CreateDirectory(dir)
	dir = path_noslash(dir)
	if dir == "" or #dir == 2 and string_sub(dir, -1) == ":" or DoCreateDir(dir) then
		return true
	end
	local dir1 = path_dir(dir)
	if dir1 ~= dir then
		CreateDirectory(dir1)
	end
	return true
end
_G.os.mkdir = CreateDirectory
--!- backwards compatibility
_G.os.CreateDirectory = CreateDirectory
--!- backwards compatibility
_G.path.CreateDirectory = CreateDirectory

local oldSave = _G.io.save
--!-
function _G.io.save(path, ...)
	CreateDirectory(path_dir(path))
	return oldSave(path, ...)
end

local function WriteBasicTextTable(t, fname)
	if fname then
		return io.save(fname, WriteBasicTextTable(t))
	end
	local q, s = {}, ''
	for i = 1, #t do
		s = (type(t[i]) == "table" and table.concat(t[i], "\t") or t[i])
		q[i] = s
	end
	if s ~= '' then
		q[#q + 1] = ''
	end
	return table.concat(q, "\r\n")
end
_G.WriteBasicTextTable = WriteBasicTextTable

local merge = LoadBasicTextTable("tab\\Mapstats merge.txt", 0)

local sortFrom, sortTo = 62, 136 -- inclusive

local t = {}

for i = sortFrom + 3, sortTo + 3 do
	table.insert(t, merge[i])
end

table.sort(t, function(a, b)
	local order = {"out", "^d", "mdk", "mdt0[1-5]", "mdr", "mdt", "^t"}
	local n1 = (a[3]:sub(1, 1) == "7" and a[3]:sub(2) or a[3]):lower()
	local n2 = (b[3]:sub(1, 1) == "7" and b[3]:sub(2) or b[3]):lower()
	local n1order, n2order = nil, nil
	for i, o in ipairs(order) do
		if n1order == nil and n1:match(o) then
			n1order = i
		end
		if n2order == nil and n2:match(o) then
			n2order = i
		end
	end
	if n1order == nil or n2order == nil then
		print("n1order or n2order is nil")
	end
	-- mdt special processing
	
	--[[if n1order == 4 or n2order == 4 then
		if n1order == 4 and n2order == 4 then
			local m1 = tonumber(n1:match("%d+"), 10)
			local m2 = tonumber(n2:match("%d+"), 10)
			if m1 <= 5 and m2 <= 5 then
				return (n1order ~= n2order) and (n1order < n2order) or (n1 < n2)
			else
				n1order = m1 > 5 and n1order + 1 or n1order
				n2order = m2 > 5 and n2order + 1 or n2order
				return (n1order ~= n2order) and (n1order < n2order) or (n1 < n2)
			end
		elseif n1order == 4 and n2order ~= 4 then
			local m1 = 2
		end
	end--]]
	
	if n1order ~= n2order then
		return n1order < n2order
	end
	return n1 < n2
end)

for i = sortFrom + 3, sortTo + 3 do
	merge[i] = t[i - sortFrom - 2]
	-- index
	merge[i][1] = tostring(i - 3)
end

WriteBasicTextTable(merge, "Mapstats processed.txt")