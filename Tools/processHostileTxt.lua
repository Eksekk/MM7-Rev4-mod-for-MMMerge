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

local rev4 = LoadBasicTextTable("tab\\Hostile rev4.txt", 0)
local merge = LoadBasicTextTable("tab\\Hostile merge.txt", 0)

local changed =
{
	["Dragon"] = "ADragon",
	["Gog"] = "AGog",
	["Minotaur"] = "AMinotaur",
	["Wyvern"] = "AWyvern",
	["Troll"] = "ATroll",
	["Blaster"] = "zBlasterGuy",
	["Mega"] = "zUltra Dragon",
	["Shark"] = "Sea Monster"
}

local MM7StartMerge = 69
local MM7EndMerge = 156

-- http://lua-users.org/wiki/StringTrim
local function trim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

for row = 3, #rev4 do
	for col = 3, #rev4 do
		if rev4[row][col] == "" or rev4[row][col] == nil then break end
		local entryrev4 = rev4[row][col]
		local entry2rev4 = rev4[col][row]
		local name = trim(rev4[row][1])
		local rowmerge = MM7StartMerge + (row - 3)
		local colmerge = MM7StartMerge + (col - 3)
		local namemerge = trim(merge[rowmerge][1])
		if name ~= namemerge and (changed[name] == nil or changed[name] ~= namemerge) then
			--print(("Found name mismatch at positions <%d, %d> rev4, <%d, %d> merge (rev4 name: %s, merge name: %s)."):format(row, col, rowmerge, colmerge, name, namemerge))
			goto continueinner
		end
		
		local entrymerge = merge[rowmerge][colmerge]
		local entry2merge = merge[colmerge][rowmerge]
		
		if entryrev4 ~= entrymerge then
			print(("Found mismatch at positions <%d, %d> rev4, <%d, %d> merge (rev4 name: %s) (rev4 value: %s, merge value: %s)."):format(row, col, rowmerge, colmerge, name, entryrev4, entrymerge))
			merge[rowmerge][colmerge] = rev4[row][col]
		end
		if entry2rev4 ~= entry2merge then
			print(("Found mismatch at positions <%d, %d> rev4, <%d, %d> merge (rev4 name: %s) (rev4 value: %s, merge value: %s)."):format(col, row, colmerge, rowmerge, name, entryrev4, entrymerge))
			merge[colmerge][rowmerge] = rev4[col][row]
		end
		::continueinner::
	end
end

WriteBasicTextTable(merge, "tab\\Hostile merge processed.txt")