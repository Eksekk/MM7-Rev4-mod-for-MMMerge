-- Ravenshore

function events.AfterLoadMap()
	Party.QBits[922] = true	-- DDMapBuff, changed for rev4 for merge
end

-- Fix for lost house tooltips
--evt.house[13] = 762
--evt.house[15] = 777
--evt.house[17] = 785
--evt.house[19] = 793
--evt.house[21] = 796
--evt.house[23] = 799
--evt.house[25] = 805
--evt.house[27] = 814
--evt.house[29] = 824
--evt.house[31] = 834
--evt.house[33] = 844
--evt.house[35] = 853
--evt.house[37] = 861
--evt.house[39] = 867
--evt.house[41] = 871
--evt.house[43] = 874
--evt.house[45] = 877
--evt.house[47] = 880
--evt.house[49] = 883
--evt.house[51] = 886
--evt.house[53] = 888
--evt.house[55] = 889
--evt.house[57] = 890
--evt.house[59] = 891
--evt.house[61] = 892
--evt.house[63] = 893
--evt.house[65] = 894
--evt.house[67] = 895
--evt.house[69] = 896
--evt.house[71] = 897
--evt.house[73] = 898
--evt.house[75] = 899
--evt.house[77] = 900
--evt.house[79] = 901
--evt.house[187] = 1565
--evt.house[203] = 757
--evt.house[209] = 1607
--evt.house[451] = 902
--evt.house[453] = 903
--evt.house[455] = 904
--evt.house[457] = 905
--evt.house[459] = 909
--evt.house[461] = 906
--evt.house[463] = 907
--evt.house[465] = 908
--evt.house[467] = 697

-- Final part of Cross continents quest
local QSet = vars.Quest_CrossContinents
if QSet and QSet.GotFinalQuest then

	function events.CanCastTownPortal(t)
		if 600 > math.sqrt((15103-Party.X)^2 + (-9759-Party.Y)^2) then
			t.CanCast = false
			evt.MoveToMap{0,0,0,0,0,0,0,0, QSet.QuestFinished and "Breach.odm" or "BrAlvar.odm"}
		end
	end

end
