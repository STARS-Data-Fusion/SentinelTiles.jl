"""
    sentinel_tile_EPSG(tile::String)::Int64

Look up the EPSG projection code for a Sentinel tile.

# Arguments
- `tile::String`: The identifier of the Sentinel tile.

# Returns
- `::Int64`: The EPSG projection code for the Sentinel tile.

# Description
This function retrieves the record for the specified Sentinel tile using the `sentinel_tile_record` function. It then checks if the EPSG field of the record is empty. If it is, an error is thrown indicating that no projection was found for the tile. Otherwise, the EPSG code is parsed as an Int64 and returned.

# Example
```julia
EPSG_code = sentinel_tile_EPSG("11SPS")

"""
function sentinel_tile_EPSG(tile::String)::Int64
    tile_row = sentinel_tile_record(tile)

    if tile_row.EPSG == ""
        error("no projection found for tile $(tile)")
    end

    tile_EPSG = parse(Int64, tile_row.EPSG)

    return tile_EPSG
end

export sentinel_tile_EPSG

function sentinel_tile_CRS(tile::String)::EPSG
    EPSG(sentinel_tile_EPSG(tile))
end

export sentinel_tile_CRS