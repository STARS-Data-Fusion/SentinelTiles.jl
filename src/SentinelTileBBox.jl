using TwoDimensional

include("SentinelTable.jl")

"""
    sentinel_tile_bbox(tile::String)::BoundingBox

Retrieve the bounding box of a Sentinel tile.

# Arguments
- `tile`: A string representing the Sentinel tile.

# Returns
- A `BoundingBox` object representing the bounding box of the Sentinel tile.

# Description
This function retrieves the record of the Sentinel tile and constructs a `BoundingBox` object using the minimum and maximum x and y coordinates from the tile record.

# Example
```julia
bbox = sentinel_tile_bbox("T30UXB")
```
"""
function sentinel_tile_bbox(tile::String)::BoundingBox
    tile_row = sentinel_tile_record(tile)
    bbox = BoundingBox(tile_row.xmin, tile_row.xmax, tile_row.ymin, tile_row.ymax)

    return bbox
end

export sentinel_tile_bbox
