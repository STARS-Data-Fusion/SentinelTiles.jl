import ArchGDAL as AG

include("SentinelTable.jl")

"""
find_sentinel_tiles(geometry::AG.IGeometry)::Vector{String}

Search for Sentinel tiles that intersect with a given geometry.

# Arguments
- `geometry::AG.IGeometry`: The geometry to check for intersection with Sentinel tiles.

# Returns
- `Vector{String}`: A vector of Sentinel tile identifiers that intersect with the given geometry.

# Example
```julia
geometry = AG.getgeom(ArchGDAL.getfeature(AG.getlayer(AG.read("target.geojson"), 0), 0))
tiles = find_sentinel_tiles(geometry)
```
"""
function find_sentinel_tiles(geometry::AG.IGeometry)::Vector{String}
    SENTINEL_DF[ArchGDAL.intersects.(SENTINEL_DF.geometry, [geometry]), :].tile
end

export find_sentinel_tiles
