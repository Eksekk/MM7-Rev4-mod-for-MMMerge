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