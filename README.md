# SentinelTiles.jl

Utilities for Geo-Referencing and Searching UTM Sentinel Tiles in Julia

The Python equivalent of this package is [sentinel_tiles](https://github.com/JPL-Evapotranspiration-Algorithms/sentinel_tiles).

Gregory H. Halverson (they/them)<br>
[gregory.h.halverson@jpl.nasa.gov](mailto:gregory.h.halverson@jpl.nasa.gov)<br>
Lead developer and designer<br>
NASA Jet Propulsion Laboratory

Margaret Johnson (she/her)<br>
[maggie.johnson@jpl.nasa.gov](mailto:maggie.johnson@jpl.nasa.gov)<br>
Concept development and project management<br>
NASA Jet Propulsion Laboratory

Kerry Cawse-Nicholson (she/her)<br>
[kerry-anne.cawse-nicholson@jpl.nasa.gov](mailto:kerry-anne.cawse-nicholson@jpl.nasa.gov)<br>
Concept development and project management<br>
NASA Jet Propulsion Laboratory

Joshua Fisher (he/him)<br>
[jbfisher@chapman.edu](mailto:jbfisher@chapman.edu)<br>
Concept development and project management<br>
Chapman University

## Usage

### sentinel_tile_dims

```
sentinel_tile_dims(tile::String, cell_size::Union{Float64,Int64})::Tuple{X,Y}
```

Calculate the raster dimensions of a Sentinel tile for use with Rasters.jl.

#### Arguments
- `tile`: A string representing the Sentinel tile.
- `cell_size`: The size of each cell in the raster. Can be either a Float64 or an Int64.

#### Returns
- A tuple of X and Y dimensions representing the raster dimensions of the Sentinel tile.

#### Description
This function first retrieves the bounding box of the Sentinel tile. It then calculates the number of columns and rows based on the cell size and the extent of the bounding box. The function finally generates the X and Y dimensions using the calculated number of columns and rows, and the coordinate reference system (CRS) of the Sentinel tile.

#### Example
```julia
using SentinelTiles

dims = sentinel_tile_dims("11SPS", 60)
```

### find_sentinel_tiles

```
find_sentinel_tiles(geometry::AG.IGeometry)::Vector{String}
```

Search for Sentinel tiles that intersect with a given geometry.

#### Arguments
- `geometry::AG.IGeometry`: The geometry to check for intersection with Sentinel tiles.

#### Returns
- `Vector{String}`: A vector of Sentinel tile identifiers that intersect with the given geometry.

#### Example
```julia
import ArchGDAL as AG
using SentinelTiles

geometry = AG.getgeom(ArchGDAL.getfeature(AG.getlayer(AG.read("target.geojson"), 0), 0))
tiles = find_sentinel_tiles(geometry)
```
