local rev4 = LoadBasicTextTable("tab\\Output map items rev4.txt", 0)
local merge = LoadBasicTextTable("tab\\Output map items merge.txt", 0)

local REV4, MERGE = 0, 1

-- hash by map and XYZ location (to find pairs)
local function getKey(x, y, z, map, type)
	local key = x .. "X" .. y .. "Y" .. z .. "Z" .. map .. "MAP" .. type
	return key
end
local coords = {}
local numberize = {2, 3, 5, 6, 7}
for i = 2, math.max(#rev4, #merge) do
	if rev4[i] then
		local mapRev4 = rev4[i][1]
		for _, num in pairs(numberize) do
			rev4[i][num] = tonumber(rev4[i][num])
		end
		local x, y, z = rev4[i][5], rev4[i][6], rev4[i][7]
		local key = getKey(x, y, z, mapRev4, REV4)
		coords[key] = rev4[i]
	end
	if merge[i] then
		if merge[i][1]:sub(1, 1) == "7" then
			merge[i][1] = merge[i][1]:sub(2)
		end
		local mapMerge = merge[i][1]
		for _, num in pairs(numberize) do
			merge[i][num] = tonumber(merge[i][num])
		end
		local x, y, z = merge[i][5], merge[i][6], merge[i][7]
		local key = getKey(x, y, z, mapMerge, MERGE)
		coords[key] = merge[i]
	end
end

-- find pairs
local p = {}
for k, v in pairs(rev4) do
	if v[1] == "Map name" then goto continue end
	k = getKey(v[5], v[6], v[7], v[1], REV4)
	local key2 = getKey(v[5], v[6], v[7], v[1], MERGE)
	if coords[key2] and v ~= coords[key2] then
		--print(k)
		assert(k:sub(1, -2) == key2:sub(1, -2))
		table.insert(p, {["rev4"] = {k, v}, ["merge"] = {key2, coords[key2]}})
	end
	::continue::
end

local exact, pairdiff, missingrev4, missingmerge = {}, {}, {}, {}

local i = 0
for _, pair in ipairs(p) do
	coords[pair["rev4"][1]] = nil
	coords[pair["merge"][1]] = nil
	--print(type(pair["rev4"][1]))
	assert(pair["rev4"][1]:sub(1, -2) == pair["merge"][1]:sub(1, -2))
	if pair["rev4"][2][4] then i = i + 1 end
	if getItem(pair["rev4"][2][3]) ~= pair["merge"][2][3]--[[ and pair["rev4"][2][4] ~= "Gold"]] then
		pairdiff[pair["rev4"][2][1]] = pairdiff[pair["rev4"][2][1]] or {}
		-- maps are identical
		local t, t2 = pair["rev4"][2], pair["merge"][2]
		table.insert(pairdiff[pair["rev4"][2][1]], t)
		table.insert(pairdiff[pair["merge"][2][1]], t2)
		table.insert(t, REV4)
		table.insert(t2, MERGE)
	else
		local t = pair["rev4"][2]
		t[3] = getItem(t[3])
		table.insert(exact, t)
	end
end
--print(i)

-- those that remain are either missing rev4 or missing merge
for k, entry in pairs(coords) do
	--assert(getKey(entry[5], entry[6], entry[7], entry[1], (tonumber(k:sub(k:len(), k:len())) == REV4) and MERGE or REV4) == k)
	if tonumber(k:sub(k:len(), k:len())) == REV4 then
		entry[3] = getItem(entry[3])
		table.insert(missingmerge, entry)
	else
		table.insert(missingrev4, entry)
	end
end

-- now just format it nicely
local rows = {"Map name\tObject id\tItem number\tItem name\tX\tY\tZ", "MATCHING ITEMS\t\t\t\t\t\t"}

function sortByKeys(t, ...)
	local n = select("#", ...)
	local order = {}
	for i = 1, n do order[i] = select(i, ...) end
	table.sort(t, function(a, b)
		for i = 1, n do
			local ares, bres = a[order[i]], b[order[i]]
			if ares ~= bres then
				return ares < bres
			end
		end
		return false
	end)
	return t
end
sortByKeys(exact, 1, 4, 3, 2)
for i, v in ipairs(exact) do
	table.insert(rows, table.concat(v, "\t"))
end

table.insert(rows, "ALMOST MATCHING ITEMS\t\t\t\t\t\t")
table.insert(rows, "REV4\t\t\t\t\t\t")
table.insert(rows, "MERGE\t\t\t\t\t\t")
table.insert(rows, "\t\t\t\t\t\t")

for map, mapItems in sortpairs(pairdiff) do
	pairdiff[map] = sortByKeys(mapItems, 1, 5, 6, 7, 8) -- map name, x, y, z, rev4 or merge
	for i = 1, #mapItems, 2 do
		table.insert(rows, table.concat(mapItems[i], "\t"))
		table.insert(rows, table.concat(mapItems[i + 1], "\t"))
		table.insert(rows, "\t\t\t\t\t\t")
	end
end

table.insert(rows, "MISSING REV4\t\t\t\t\t\t")
table.insert(rows, "\t\t\t\t\t\t")

sortByKeys(missingrev4, 1, 5, 6, 7)

for _, v in ipairs(missingrev4) do
	table.insert(rows, table.concat(v, "\t"))
end

table.insert(rows, "\t\t\t\t\t\t")
table.insert(rows, "MISSING MERGE\t\t\t\t\t\t")
table.insert(rows, "\t\t\t\t\t\t")

sortByKeys(missingmerge, 1, 5, 6, 7)

for _, v in ipairs(missingmerge) do
	table.insert(rows, table.concat(v, "\t"))
end

local file = io.open("mapcmp/results.txt", "wb")
file:write(table.concat(rows, "\r\n"))
file:close()

-- Map name	Object id	Item number	Item name	X	Y	Z
-- benefits of this script:
-- added missing The Slayer in 7d28.blv (EI dragon cave)
-- fixed 7d35.blv Zokarr's Axe position (was suspended in air), the bug didn't affect gameplay though as axe landed on the ground
-- 7out01.odm two inaccessible horseshoes (doesn't matter really, unless they were supposed to spawn on ship (current pos is below it))
-- 7out02.odm slightly changed horseshoe location (doesn't matter), added gold beneath surface (doesn't matter, it doesn't appear on ground)