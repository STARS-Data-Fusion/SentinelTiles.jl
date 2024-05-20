using Test
using TwoDimensional
using SentinelTiles

@test sentinel_tile_EPSG("11SPS") == 32611
@test sentinel_tile_centroid("11SPS") == TwoDimensional.Point{Float64}(654900.0, 3.64512e6)
@test sentinel_tile_centroid_latlon("11SPS") == Point{Float64}(-115.34316201948356, 32.93338628938682)
@test sentinel_tile_bbox("11SPS") == BoundingBox{Float64}(600000.0, 709800.0, 3.59022e6, 3.70002e6)
