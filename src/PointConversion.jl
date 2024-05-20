using TwoDimensional
import ArchGDAL as AG

"""
    AGPoint

Type definition for ArchGDAL point. It represents a point in the ArchGDAL geometry model.
"""
AGPoint = AG.IGeometry{AG.wkbPoint}

export AGPoint

"""
    from_AG(point::AGPoint)::Point

Converts an ArchGDAL projected point to a `Point` in the `TwoDimensional` module.

# Arguments
- `point::AGPoint`: The ArchGDAL point to be converted.

# Returns
- `Point`: The converted point in the `TwoDimensional` module.
"""
function from_AG(point::AGPoint)::Point
    Point(AG.getx(point, 0), AG.gety(point, 0))
end

export from_AG

"""
    from_AG_latlon(point::AGPoint)::Point

Converts an ArchGDAL geographic point to a `Point` in the `TwoDimensional` module.

# Note
Geographic points in ArchGDAL are (latitude, longitude), which is reversed from (x, y) used for projected points.

# Arguments
- `point::AGPoint`: The ArchGDAL point to be converted.

# Returns
- `Point`: The converted point in the `TwoDimensional` module.
"""
function from_AG_latlon(point::AGPoint)::Point
    Point(AG.gety(point, 0), AG.getx(point, 0))
end

export from_AG_latlon

"""
    to_AG(point::Point)::AGPoint

Converts a projected `Point` from the `TwoDimensional` module to an ArchGDAL point.

# Arguments
- `point::Point`: The `Point` from the `TwoDimensional` module to be converted.

# Returns
- `AGPoint`: The converted ArchGDAL point.
"""
function to_AG(point::Point)::AGPoint
    AG.createpoint(point.x, point.y)
end

"""
    to_AG_latlon(point::Point)::AGPoint

Converts a geographic `Point` from the `TwoDimensional` module to an ArchGDAL point.

# Arguments
- `point::Point`: The `Point` from the `TwoDimensional` module to be converted.

# Returns
- `AGPoint`: The converted ArchGDAL point.
"""
function to_AG_latlon(point::Point)::AGPoint
    AG.createpoint(point.y, point.x)
end

export to_AG
