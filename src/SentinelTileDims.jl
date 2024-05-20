using Rasters
using DimensionalData.Dimensions.LookupArrays

include("SentinelTileBBox.jl")
include("SentinelTileCRS.jl")

"""
    sentinel_tile_dims(tile::String, cell_size::Union{Float64,Int64})::Tuple{X,Y}

Calculate the raster dimensions of a Sentinel tile for use with Rasters.jl.

# Arguments
- `tile`: A string representing the Sentinel tile.
- `cell_size`: The size of each cell in the raster. Can be either a Float64 or an Int64.

# Returns
- A tuple of X and Y dimensions representing the raster dimensions of the Sentinel tile.

# Description
This function first retrieves the bounding box of the Sentinel tile. It then calculates the number of columns and rows based on the cell size and the extent of the bounding box. The function finally generates the X and Y dimensions using the calculated number of columns and rows, and the coordinate reference system (CRS) of the Sentinel tile.

# Example
```julia
dims = sentinel_tile_dims("11SPS", 60)
```
"""
function sentinel_tile_dims(tile::String, cell_size::Union{Float64,Int64})::Tuple{X,Y}
    # Get the bounding box of the Sentinel tile
    bbox = sentinel_tile_bbox(tile)
        
    # Extract the minimum and maximum x and y coordinates from the bounding box
    xmin = bbox.xmin
    ymin = bbox.ymin
    xmax = bbox.xmax
    ymax = bbox.ymax

    # Get the EPSG code of the Sentinel tile
    tile_EPSG = sentinel_tile_EPSG(tile)

    # Calculate the number of columns and rows based on the cell size and the extent of the bounding box
    cols = Int(trunc((ymax - ymin) / cell_size))
    rows = Int(trunc((xmax - xmin) / cell_size))

    # Generate the X dimension using the calculated number of rows, the cell size, and the CRS of the Sentinel tile
    x_dim = X(Projected(LinRange(xmin, xmin + (rows - 1) * cell_size, rows), order=ForwardOrdered(), span=Regular(cell_size), sampling=Intervals(Start()), crs=convert(WellKnownText, EPSG(tile_EPSG))))

    # Generate the Y dimension using the calculated number of columns, the cell size, and the CRS of the Sentinel tile
    y_dim = Y(Projected(LinRange(ymax - cell_size, ymax - cols * cell_size, cols), order=ReverseOrdered(), span=Regular(-cell_size), sampling=Intervals(Start()), crs=convert(WellKnownText, EPSG(tile_EPSG))))

    # Combine the X and Y dimensions into a tuple
    dims = (x_dim, y_dim)

    return dims
end

export sentinel_tile_dims
