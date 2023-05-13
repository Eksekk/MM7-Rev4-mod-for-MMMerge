-- restore correct chest UVs after editing with bugged MMEditor version
local mm7MapsDir = ".\\MM7 maps\\"

function try()
    local mapName, mapNameStripped = Map.Name, (Map.Name:match("^[7]*(.*)"))
    local oldState = internal.unpersist(io.load(mm7MapsDir .. mapNameStripped .. ".dat"))
    local UniqueVertex, UniqueFacet = Editor.AddUnique()
    for roomId, room in pairs(oldState.Rooms) do
        for facet, facetId in pairs(room.BaseFacets or room.Facets) do
            for vertexId, vertex in pairs(facet.Vertexes) do
                local x, y, z = XYZ(vertex)
                facet.Vertexes[vertexId] = UniqueVertex(x, y, z, vertex)
            end
            local resultFacet = UniqueFacet(facet.Vertexes, facet)
            if resultFacet ~= facet then
                for _, prop in ipairs{"BitmapU", "BitmapV", "AlignTop", "AlignRight", "AlignBottom", "AlignLeft"} do
                    resultFacet[prop] = facet[prop]
                end
            end
        end
    end
    Editor.NeedStateSync()
end

--for k, v in pairs(Editor.State.Rooms[2].Facets) do print(k, v) end