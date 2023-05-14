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
    -- needed when doing batch change???
    -- Editor.NeedStateSync()
end

function restoreCorrectUv()
    BatchLoad(rev4mMapsDir, outputDir, callback)
end