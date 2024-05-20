import GeoDataFrames as GDF

# Define the path to the Sentinel-2 GeoJSON file
SENTINEL_FILENAME = joinpath(@__DIR__, "sentinel2.geojson")

# Load the GeoJSON file into a DataFrame
SENTINEL_DF = GDF.read(SENTINEL_FILENAME)

"""
    sentinel_tile_record(tile::String)

Search for a specific Sentinel tile in the internally stored DataFrame and return its record.

# Arguments
- `tile::String`: The identifier of the Sentinel tile to search for.

# Returns
- `DataFrameRow`: The record of the specified Sentinel tile.

# Errors
- Throws an error if the specified tile is not found in the DataFrame.
"""
function sentinel_tile_record(tile::String)
    # find the sentinel tile in the data frame
    search_results = SENTINEL_DF[isequal.(SENTINEL_DF.tile, tile), :]

    # throw an error if the tile isn't found
    if size(search_results)[1] == 0
        error("tile $(tile) not found")
    end

    # pull the row out of the data frame if the tile is found
    tile_row = search_results[1, :]

    return tile_row
end

export sentinel_tile_record
