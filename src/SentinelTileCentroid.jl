using TwoDimensional
using GeoFormatTypes

include("PointConversion.jl")
include("SentinelTileBBox.jl")
include("SentinelTileCRS.jl")

"""
    sentinel_tile_centroid(tile::String)::Point

Calculate the Universal Transverse Mercator (UTM) centroid of a Sentinel satellite image tile.

# Arguments
- `tile::String`: The identifier of the Sentinel tile.

# Returns
- `::Point`: The UTM coordinates of the centroid of the Sentinel tile.

# Description
This function first determines the bounding box of the specified Sentinel tile using the `sentinel_tile_bbox` function. It then calculates and returns the centroid of this bounding box.

# Example
```julia
centroid = sentinel_tile_centroid("11SPS")
```
"""
function sentinel_tile_centroid(tile::String)::Point
    center(sentinel_tile_bbox(tile))
end

export sentinel_tile_centroid

"""
    sentinel_tile_centroid_latlon(tile::String)::Point

Calculate the geographic centroid (latitude and longitude) of a Sentinel satellite image tile.

# Arguments
- `tile::String`: The identifier of the Sentinel tile.

# Returns
- `::Point`: The geographic coordinates (latitude and longitude) of the centroid of the Sentinel tile.

# Description
This function first calculates the Universal Transverse Mercator (UTM) centroid of the specified Sentinel tile using the `sentinel_tile_centroid` function. It then determines the EPSG code of the tile using the `sentinel_tile_EPSG` function. The UTM centroid is then reprojected to geographic coordinates using the `AG.reproject` function from the ArchGDAL package. The EPSG code 4326 is used for the target coordinate system, which represents the WGS84 geographic coordinate system.

# Example
```julia
centroid_latlon = sentinel_tile_centroid_latlon("11SPS")

"""
function sentinel_tile_centroid_latlon(tile::String)::Point
    centroid_UTM = sentinel_tile_centroid(tile)
    tile_EPSG = sentinel_tile_EPSG(tile)
    centroid_latlon = from_AG_latlon(AG.reproject(to_AG(centroid_UTM), EPSG(tile_EPSG), EPSG(4326)))

    return centroid_latlon
end

export sentinel_tile_centroid_latlon
