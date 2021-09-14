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

-- end of functions taken from MMExtension repo

local rev4 = LoadBasicTextTable("tab\\Items rev4.txt", 0)
local merge = LoadBasicTextTable("tab\\Items merge.txt", 0)

-- SpriteIndex mappings --
local spriteIndexMappings = {}

for i = 3, #rev4 - 1 do
	if merge[i + 803][3]:match("^%_") then -- dummy item in merge
		goto continue
	end
	local sirev4 = tonumber(rev4[i][12])
	
	local simerge = tonumber(merge[i + 803][12])
	if spriteIndexMappings[sirev4] ~= nil and spriteIndexMappings[sirev4] ~= simerge then
		print(("Found conflicting SpriteIndex mappings, old item: %d, new item: %d"):format(spriteIndexMappings[sirev4][2], i - 2))
		print(sirev4, simerge)
		goto continue
	end
	spriteIndexMappings[sirev4] = simerge
	::continue::
end

--[[ FINDING PICTURE MAPPINGS ]]--

local function tfind(t, what)
	for k, v in ipairs(t) do
		if v == what then
			return k
		end
	end
	return nil
end

local pictureMappings = {}

local rev4pics, mergepics = {}, {}

for i in path.find("items rev4\\*.bmp") do
	local file = io.open(i)
	local content = file:read("*a")
	
	local name = path.setext(path.name(i), ""):lower()
	rev4pics[content] = rev4pics[content] or {}
	table.insert(rev4pics[content], name)
	io.close(file)
end

for i in path.find("items merge\\*.bmp") do
	local file = io.open(i)
	local content = file:read("*a")
	mergepics[content] = path.setext(path.name(i), "")
	io.close(file)
end

local skips = {}
skips["null"] = true

for i = 3, #rev4 - 1 do
	local itemPicContent = nil
	local rev4name = rev4[i][2]
	if rev4name == "0" or skips[rev4name] ~= nil then
		goto continue
	end
	for content, names in pairs(rev4pics) do
		local index = tfind(names, rev4name)
		if index ~= nil then
			itemPicContent = content
			break
		end
	end
	if itemPicContent == nil then
		print("Couldn't find picture for name " .. rev4name)
	end
	
	local mergename = mergepics[itemPicContent]
	
	if mergename == nil then
		print("Couldn't find merge picture for name " .. rev4name)
	end
	
	pictureMappings[rev4name] = mergename
	::continue::
end

pictureMappings["item070"] = "7item070" -- for some reason it is changed in merge

for i = 3, #rev4 - 1 do
	local row = merge[i + 803]
	local roworig = table.copy(row)
	local rowrev4 = rev4[i]
	for j = 2, 17 do
		row[j] = rowrev4[j]
	end
	-- image
	if pictureMappings[rowrev4[2]:lower()] == nil and rowrev4[2] ~= "null" then
		print("Couldn't find a picture for file name " .. rowrev4[2])
	end
	row[2] = pictureMappings[rowrev4[2]:lower()] or rowrev4[2]
	-- spriteIndex
	local n = tonumber(rowrev4[12])
	if rowrev4[11]:lower():find("potion") ~= nil then -- 11 = not identified name
	end
	if spriteIndexMappings[n] == nil then
		print("Couldn't find sprite index mapping for spriteIndex " .. n)
	end
	row[12] = spriteIndexMappings[n] or rowrev4[12]
	
	-- equip x, equip y
	row[15] = roworig[15]
	row[16] = roworig[16]
end