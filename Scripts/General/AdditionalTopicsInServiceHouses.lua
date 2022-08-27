
local newHouseTopics =
{
	[const.HouseType.Tavern] =
	{
		[const.HouseScreens.ArcomageMenu] =
		{
			SpecifiedScreens = true, -- key is either screen id or table of screen ids
			{
				Name = "NestedTest",
				Topic = "Testing nested topic",
				Text = "Lorem ipsum",
				Condition = function(houseId) return Party.Gold >= 300000 end,
				Action = function(houseId)
					Party.Gold = Party.Gold + 200
					-- return true -- handled, we don't display text
					-- return false/no return -- not handled, we display text
				end,
			}
		},
		{
			-- no specified screens, default is house type's main screen
			Name = "NormalTest",
			Topic = "Testing topic",
			Text = "Lorem ipsum2",
			Condition = function(houseId) return Party.Food >= 30 end,
			Action = function(houseId)
				Party.Food = Party.Food + 5
				return true -- handled, we don't display text
				-- return false/no return -- not handled, we display text
			end,
		}
	},
	[const.HouseType.Temple] = 
	{
		{
			Name = "TempleTopicTest",
			Topic = "Bless weapon (500 gold)",
			Action = function(houseId)
				if Party.Gold >= 500 then
					HouseMessage("Your weapon is now blessed. It will deal double damage to undead, and the spell will last 8 hours." ..
				" Go on and slay some undead for us!")
					Party.Gold = Party.Gold - 500
				else
					HouseMessage("You don't have enough gold! I'm sorry but we have to earn for living too.")
				end
				return true
			end
		}
	},
	[const.HouseType["Town Hall"] ] =
	{
		{
			Name = "TownHallTopicTest"
		}
	}
}

local editedOriginalTopics =
{
	-- using functions to allow changing behavior depending on house id
	[const.HouseScreens.Train] =
	{
		GetTopic = function(houseId) return "Lol, no training today!" end,
		GetText = function(houseId) return "ABCD" end,
		GetAction = function(houseId) return function() end end, -- return true = don't display text automatically
		GetCondition = function(houseId) return true end,
	},
	[const.HouseScreens.Donate] =
	{
		GetTopic = function(houseId) return "Lol, no donating today!" end,
		GetText = function(houseId) return "No donations available. Sorry for the inconvenience!" end,
		GetAction = function(houseId) return function() end end, -- return true = don't display text automatically
		GetCondition = function(houseId) return true end,
	},
	[const.HouseScreens.BountyHunt] =
	{
		GetTopic = function(houseId) return "Testing" end,
		GetText = function(houseId) return "Testing2" end,
		GetAction = function(houseId) return function() end end, -- return true = don't display text automatically
		GetCondition = function(houseId) return true end,
	}
}

--[[function structs.f.HardcodedNpcTopicData(define)
	define
	.u4  'StartX'
	.u4  'StartY'
	.u4  'TextWidth'
	.u4  'TextHeight'
	.u4  'EndX' -- StartX + TextWidth - 1
	.u4  'EndY' -- StartY + TextHeight - 1
	[0x24].u4  'HouseScreenOnClick'
	[0x30].u4  'PrevTopicPtr'
	.u4  'NextTopicPtr'
end]]

--[[
Address=0041C3AA
Disassembly=mov dword ptr ss:[ebp-C],eax
Comment=amount of all possible house topics + 2

]]

-- first two seem to be unchanging and don't correspond to any action
--HardcodedNpcTopics = {structs.HardcodedNpcTopicData:new(mem.u4[mem.u4[0x519324] + 0x4C])}
--HardcodedNpcTopics[2] = structs.HardcodedNpcTopicData:new(HardcodedNpcTopics[1].NextTopicPtr)

local function getNextFreeId()
	local i, invertedHouseScreens = 150, table.invert(const.HouseScreens)
	while invertedHouseScreens[i] do
		i = i + 1
	end
	
	return i
end

local topicsIds = {} -- TODO: useless (just look at two last lines of below function)

local function processTopic(topic)
	local id = getNextFreeId()
	const.HouseScreens[topic.Name] = id
	topicsIds[topic.Name] = id
end

-- TODO: fix this later, need to handle unlimited amount of nested topics
for houseType, topics in pairs(newHouseTopics) do
	for i, topic in pairs(topics) do
		if type(topic) == "table" then
			if topic.SpecifiedScreens then
				for i, topic in ipairs(topic) do
					processTopic(topic)
				end
			else
				processTopic(topic)
			end
		end
	end
end

if false then
	-- topics count
	mem.u4[0x5A5714] = NEW_TOPICS_COUNT
end

function events.PopulateHouseDialog(t)
	if t.PicType == const.HouseType.Temple then
		-- work around Merge not using this event
		if t.Result[1] == const.HouseScreens.Heal or t.Result[1] == "Heal" then
			local evarg = {CanShow = mem.call(0x4B57BD, 1, Party[Game.CurrentPlayer]["?ptr"])}
			events.call("CanShowHealTopic", evarg)
			if evarg.CanShow == 0 then
				table.remove(t.Result, 1)
			end
		end
		table.insert(t.Result, "TempleTopicTest")
	end
end

--[[ not needed, house type is at 0xFFD404
local hookSpace, createHouseTopicsHouseType = mem.hookalloc(15) -- 2 hooks + jump back
mem.copycode(0x4B250A, 5, hookSpace + 5)

mem.hook(hookSpace, function(d)
	createHouseTopicsHouseType = d.ecx
end)
mem.asmpatch(0x4B250A, "jmp absolute " .. hookSpace)
]]

local performActionHook = function(houseType, returnAddress)
	return function(d)
		local editedOriginalTopic = editedOriginalTopics[d.eax]
		if editedOriginalTopic then
			local textHandled = editedOriginalTopic.GetAction(Game.GetCurrentHouse())()
			if not textHandled then
				HouseMessage(editedOriginalTopic.GetText(Game.GetCurrentHouse()))
			end
			d:push(returnAddress)
			return true
		end
		local houseTypeEntry = newHouseTopics[houseType]
		if not houseTypeEntry then return end
		
		local topicId, topicName = d.eax
		for k, v in pairs(topicsIds) do
			if v == d.eax then
				topicName = k
				break
			end
		end
		if not topicName then return end
		--local topicsAmount = mem.u4[0x5A5714]
		local topicToPerform
		-- we don't care about topicObj.SpecifiedScreens here
		-- TODO: look deep into table
		for i, v in ipairs(houseTypeEntry) do
			if v.Name == topicName then
				topicToPerform = v
				break
			end
		end
		if not topicToPerform then
			error(string.format("Topic object not found for topic %d (%s)!", topicId, topicName))
		end
		local textHandled = topicToPerform.Action(Game.GetCurrentHouse())
		if not textHandled then
			HouseMessage(topicToPerform.Text)
		end
		d:push(returnAddress)
		return true
	end
end

-- TEMPLE --

-- perform topic action
mem.autohook(0x4B587A, performActionHook(const.HouseType.Temple, 0x4B5E5B))

-- display topics
local NewCode = mem.asmpatch(0x4B5D41, [[
	xor esi, esi
	xor edi, edi
	@hook:
	nop
	nop
	nop
	nop
	nop
	test eax, eax ; end?
	jz absolute 0x4B5D77
	; mov edx,dword ptr [ss:ebp-0xC] ; text ptr
	mov ecx,dword ptr [ds:0x5DB918] ; screen ptr
	push ebx
	push ebx
	lea eax,dword ptr [ss:ebp-0x78]
	push eax
	call absolute 0x449CFC ; getTextHeight
	mov ecx, dword ptr [ds:0x519324]
	add dword ptr [ss:ebp-0x8],eax
	inc edi
	jmp @hook
]])

local topics, topicsPtrs = nil, {}
mem.hook(NewCode + 4, function(d)
	-- have to get topic ids manually because alternative is either copying some of Core/npc.lua there
	-- (and having to remember to update it occasionally) or modifying it (which isn't preferable, especially for core script)
	if not topics then
		local houseData = mem.u4[0x519324]
		local button = structs.Button:new(mem.u4[houseData + 0x4C])
		while button.ActionType ~= 0x195 do -- process house screen?
			button = structs.Button:new(button.NextItemPtr)
			if button.ActionType == 0x195 and button.NextItemPtr == 0 then
				break
			end
		end
		topics = {}
		while button.ActionType == 0x195 do -- collect all topics
			table.insert(topics, button.ActionParam)
			if button.NextItemPtr == 0 then break end
			button = structs.Button:new(button.NextItemPtr)
		end
	end
	
	if d.edi >= #topics then
		d.eax = 0
		topics = nil
		return
	end
	local houseScreen = topics[d.edi + 1]
	local editedOriginalTopic = editedOriginalTopics[houseScreen]
	local handled = false
	if editedOriginalTopic and editedOriginalTopic.GetTopic and type(editedOriginalTopic.GetTopic) == "function" then
		d.edx = mem.topointer(editedOriginalTopic.GetTopic(Game.GetCurrentHouse()))
		table.insert(topicsPtrs, d.edx)
		handled = true
	else
		local houseType = mem.u4[0xFFD404]
		local topicId, topicName = houseScreen
		for k, v in pairs(topicsIds) do
			if v == topicId then
				topicName = k
				break
			end
		end
		if topicName then
			--local topicsAmount = mem.u4[0x5A5714]
			local topicToPerform
			for k, topicObj in pairs(newHouseTopics) do
				-- we don't care about topicObj.SpecifiedScreens here
				for i, v in pairs(topicObj) do
					if v.Name == topicName then
						topicToPerform = v
						break
					end
				end
				if topicToPerform then break end
			end
			if topicToPerform then
				d.edx = mem.topointer(topicToPerform.Topic)
				table.insert(topicsPtrs, d.edx)
				handled = true
			end
		end
	end
	if not handled then
		local defaultTexts =
		{
			[const.HouseScreens.Heal] = d.ebp - 0x1A4,
			[const.HouseScreens.Donate] = d.ebp - 0x1A4 + 1 * 0x64,
			[const.HouseScreens.LearnSkills] = d.ebp - 0x1A4 + 2 * 0x64,
		}
		d.edx = defaultTexts[houseScreen] or error(string.format("Couldn't find default text for house screen %d (%s)!", houseScreen, table.invert(const.HouseScreens)[houseScreen]))
		table.insert(topicsPtrs, d.edx)
	end
	d.eax = 1
end)

mem.autohook2(0x4B5DEC, function(d)
	local amount = mem.u4[d.ebp - 0x10]
	d.edx = topicsPtrs[amount - 1]
end)

NewCode = mem.asmpatch(0x4B5E32, [[
	push edx
	push edx
	nop
	nop
	nop
	nop
	nop
	mov dword ptr [ss:esp + 0x4], edx
	pop edx
	push eax
	push ecx
]])

mem.hook(NewCode + 2, function(d)
	local amount = mem.u4[d.ebp - 0x10]
	d.edx = topicsPtrs[amount - 1]
	if amount - 1 == #topicsPtrs then
		topicsPtrs = {}
	end
end)

-- town hall
-- perform topic action
mem.autohook(0x4B5EF2, performActionHook(const.HouseType["Town Hall"], 0x4B62D5))