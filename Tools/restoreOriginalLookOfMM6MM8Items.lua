--[[ 1. create set of all item pictures from MM6/MM8
2. for each item:
3. check if item's picture is taken from MM8/MM6
4. if so, restore its MM7 look and description and delete modded pic file

--]]

local imageSet = {}
for i in path.find("mm6mm8icons/*.bmp") do
	local file = io.open(i)
	local content = file:read("*a")
	file:close()
	imageSet[content] = true
end

local rev4 = LoadBasicTextTable("tab\\Items modified.txt", 0)
local merge = LoadBasicTextTable("tab\\Items merge2.txt", 0)

for i = 806, 939 do
	local row = rev4[i]
	local picFile = row[2]
	local file = io.open("rev4icons\\" .. picFile .. ".bmp")
	local closed = false
	if file then
		local content = file:read("*a")
		if imageSet[content] then
			print("Processing item " .. row[3])
			row[3] = merge[i][3] -- name
			row[17] = merge[i][17] -- description
			file:close()
			closed = true
			os.remove("rev4icons/" .. picFile .. ".bmp")
		end
		if not closed then
			file:close()
		end
	end
end

WriteBasicTextTable(rev4, "Items processed.txt")