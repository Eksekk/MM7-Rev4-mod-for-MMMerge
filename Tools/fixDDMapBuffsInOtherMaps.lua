local function isOutdoorMM7(name)
	local m = tonumber(name:match("%d+") or "")
	return (name:find("out")) and
	(name:sub(1, 1) == "7" or
	(m and m >= 9 and m <= 12) or
	(m and m == 14))
end

for i in path.find(rev4m.path.originalOtherMapScripts .. "*.lua") do
	print("Current file: " .. path.name(i))
	local file = io.open(i)
	local content = file:read("*a")
	file:close()
	local name = path.name(i):lower()
	if isOutdoorMM7(name) then goto continue end
	-- convert DDMapBuffs
	local done
	content, done = content:gsub("Party%.QBits%[(%d+)%] = true	%-%- DDMapBuff", function(buff)
		buff = tonumber(buff)
		return ("Party.QBits[%d] = true	-- DDMapBuff, changed for rev4 for merge"):format(getDDMapBuff(buff))
	end)
	if done ~= 1 and name:find("out") ~= nil then
		print("Outdoor map " .. name .. ", no DDMapBuff replacement made - check this")
	end
	if done == 1 then
		io.save(rev4m.path.processedOtherMapScripts .. path.name(i), content)
	end
	::continue::
end