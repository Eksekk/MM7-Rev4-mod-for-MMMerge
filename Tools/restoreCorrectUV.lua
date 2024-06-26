-- restore correct chest UVs after editing with bugged MMEditor version (no offense to Grayface)
local mm7MapsDir = ".\\MM7 maps\\"
local rev4mMapsDir = ".\\rev4m maps dat\\"
local outputDir = ".\\rev4m maps compiled and fixed\\"

local originalToDuplicated = {
    ["mdt12orig.blv"] = "mdt12.blv",
    ["mdt09orig.blv"] = "mdt09.blv",
    ["7d08orig.blv"] = "7d08.blv",
    ["7d12orig.blv"] = "7d12.blv",
    ["7nwcorig.blv"] = "7nwc.blv"
}

-- this function restores all facet bitmap-related properties from corresponding base mm7 map
local function callback(state, map)
    -- get base mm7 map name corresponding to current merge map
    printf("received map name: %s", map)
    -- remove .dat extension
    map = path.setext(path.name(map), "")
    local mapNameBase = (originalToDuplicated[map] or map):match("^[7]*(.*)") or ""
    if mapNameBase:len() == 0 then
        printf("No matching base map for map %q", map)
        error"fail"
        return
    end
    -- load mm7 map Editor.State
    local ok, content = pcall2(io.load, mm7MapsDir .. mapNameBase .. ".dat")
    if not ok then
        printf("Load not successful: %s", mapNameBase)
        error"fail"
    end
    local oldState = internal.unpersist(content)
    if not oldState.Rooms then return end -- outdoor map
    -- get function for adding stuff
    -- stuff will be added to passed state???
    local UniqueVertex, UniqueFacet = Editor.AddUnique(state)
    -- for each facet of each room do
    for roomId, room in pairs(oldState.Rooms) do
        for facet, facetId in pairs(room.BaseFacets or room.Facets) do
            -- add all vertices
            for vertexId, vertex in pairs(facet.Vertexes) do
                local x, y, z = XYZ(vertex)
                facet.Vertexes[vertexId] = UniqueVertex(x, y, z, vertex)
            end
            -- add facet
            local resultFacet = UniqueFacet(facet.Vertexes, facet)
            if resultFacet ~= facet then
                -- new doesn't match old - restore properties I'm interested in
                for _, prop in ipairs{"BitmapU", "BitmapV", "AlignTop", "AlignRight", "AlignBottom", "AlignLeft"} do
                    resultFacet[prop] = facet[prop]
                end
            end
        end
    end

    -- fix 137N monster spell skill bug
    for mon in Editor.State.Monsters do
        for _, k in ipairs{"Spell", "Spell2"} do
            local skillKey = k .. "Skill"
            local s, m = SplitSkill(mon[skillKey])
            if s > 63 and s < 512 then
                mon[skillKey] = JoinSkill(mon[skillKey] % 64, math.min(4, mon[skillKey]:div(64) + 1))
                printf("Fixing %s skill of monster %q: before %d %d, after %d %d", k, Game.MonstersTxt[mon.Id].Name, s, m, SplitSkill(mon[skillKey]))
            end
        end
    end

    -- castle harmondale doors
    -- doors are in Map.Doors, not state
    if map == "7d29.blv" then
        
    end
    -- needed when doing batch change???
    -- Editor.NeedStateSync()
end

function restoreCorrectUv()
    rev4m.batchCompilingMaps = true -- needed to avoid crash from "monster flickering" fix from MiscTweaks.lua
    BatchLoad(rev4mMapsDir, outputDir, callback, function() rev4m.batchCompilingMaps = nil end)
end

-- r = select(2, nthNext(Editor.State.Rooms, 3))
--------- these doors are different than Map.Doors
-- for facet, id in pairs(r.Facets) do if facet.Door then print(id) end end
-- local i = 0; for facet, id in pairs(r.Facets) do i = i + 1; if facet.Door then print(i) end end