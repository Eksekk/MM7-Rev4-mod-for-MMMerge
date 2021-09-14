function mtm(str)
	return evt.MoveToMap{Name = str}
end

function getItem(item)
	if item >= 220 and item <= 271 then -- potions
		return item
	end
	return item + 802
end