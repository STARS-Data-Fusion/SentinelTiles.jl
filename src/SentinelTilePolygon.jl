using GeoFormatTypes
import ArchGDAL as AG

include("SentinelTileBBox.jl")
include("SentinelTileCRS.jl")

"""
    sentinel_tile_polygon(tile::String)::AG.IGeometry{AG.wkbPolygon}

Create a polygon for a given Sentinel tile.

# Arguments
- `tile::String`: The Sentinel tile identifier.

# Returns
- `polygon::AG.IGeometry{AG.wkbPolygon}`: The polygon representing the tile.
"""
function sentinel_tile_polygon(tile::String)::AG.IGeometry{AG.wkbPolygon}
    # Get the bounding box of the tile
    bbox = sentinel_tile_bbox(tile)
    # Create a polygon from the bounding box
    polygon = AG.createpolygon([(bbox.xmin, bbox.ymax), (bbox.xmax, bbox.ymax), (bbox.xmax, bbox.ymin), (bbox.xmin, bbox.ymin)])

    return polygon
end

export sentinel_tile_polygon

"""
    sentinel_tile_polygon_latlon(tile::String)::AG.IGeometry{AG.wkbPolygon}

Create a polygon for a given Sentinel tile and reproject it to latitude/longitude coordinates.

# Arguments
- `tile::String`: The Sentinel tile identifier.

# Returns
- `polygon_latlon::AG.IGeometry{AG.wkbPolygon}`: The polygon representing the tile in latitude/longitude coordinates.
"""
function sentinel_tile_polygon_latlon(tile::String)::AG.IGeometry{AG.wkbPolygon}
    # Get the polygon of the tile
    polygon = sentinel_tile_polygon(tile)
    # Get the CRS of the tile
    crs = sentinel_tile_CRS(tile)
    # Reproject the polygon to latitude/longitude coordinates
    polygon_latlon = AG.reproject(polygon, crs, EPSG(4326))

    return polygon_latlon
end

export sentinel_tile_polygon_latlon
