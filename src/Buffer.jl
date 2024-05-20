using TwoDimensional

"""
buffer(bbox::BoundingBox, buffer::Float64)::BoundingBox

Expand the given bounding box symmetrically in all directions.

# Arguments
- `bbox::BoundingBox`: The original bounding box to be expanded.
- `buffer::Float64`: The distance by which the bounding box should be expanded in each direction.

# Returns
- `BoundingBox`: A new bounding box that is larger than the original bounding box. The new bounding box is expanded by the `buffer` distance in the x and y directions.

# Example
```julia
bbox = BoundingBox(1.0, 2.0, 3.0, 4.0)
buffered_bbox = buffer(bbox, 0.5)
```
"""
function buffer(bbox::BoundingBox, buffer::Float64)::BoundingBox
    return BoundingBox(bbox.xmin - buffer, bbox.xmax + buffer, bbox.ymin - buffer, bbox.ymax + buffer)
end
