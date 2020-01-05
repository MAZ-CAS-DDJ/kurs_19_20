# GEOPANDAS CHEAT SHEET
by Simon Schmid. Work in progress, without any guarantees. Spotted a mistake? Mail [here](mailto:simon@netwings.ch).

## SETUP

**`import geopandas as gpd`**                  *- the basic library*

**`from shapely.geometry import Point, LineString, Polygon`** *- Needed to deal with geometric shapes**

## FILE IN / OUT

**`gdf.read_file(filename)`**                   *- read a file into a dataframe. Can be .shp or other*  ([documentation](http://geopandas.org/io.html))

**`gdf.to_file(filename)`**                     *- save a geodataframe to a file. Default is .shp*
- `driver='GeoJSON'`                            *- as GeoJSON*

## CONSTRUCT GEODATAFRAMES

**`gpd.GeoDataFrame(df)`**                      *- create a geodataframe out of a dataframe*
- `geometry=row`                                *- using a given colunn as geometry*

**`gdf.geometry`**                               *- the geometry column in the gdf. will plot the shape if used on single row*

**`gdf.set_geometry('column')`**                 *- change the column that cointains the geometry*

## COORDINATE SYSTEMS

**`gdf.crs`**                                    *- the CRS (coordinate reference system) property* ([documentation](http://geopandas.org/projections.html))
- `= {'init': 'epsg:xxxx'}`                      *- Initialize the CRS. Choose any EPSG number. See:* https://epsg.io/

**`gdf.to_crs({'proj': xxxx})`**                 *- Transform coordinates to other CRS using abbreviation*
- `'merc'`                                       *- Mercator*
- `'tmerc'`                                      *- transverse mercator*
- `'aea'`                                        *- albers equal area*

**`gdf.to_crs(epsg=number)`**                       *- change the CRS according to EPSG code (European Petroleum Survey Group)*
- `3857`                                         *- mercator*
- `4326`                                         *- world geodetic system*
- `2163`                                         *- nice aea projection for the USA*
- `5071`                                         *- another good one for the USA*
- `3395`                                         *- mercator (anotherone)*
- `21781`                                        *- swiss coordinate system*

## SHAPES

### Create Shapes

**`Point(x, y)`**                               *- Create a point at coordinate pair (x, y)*

**`Linestring([Point1, Point2])`**              *- Create a Line through 2 Points*

**`Polygon(pointlist)`**                        *- Create a Polygon out of a list of points (can be list of coordinate pairs)*

### Shape properties

**`shape.wkt`**                                      *- returns the shape in raw data notation*

**`shape.geom_type`**                                *- returns the geometry type*

**`shape.area`**                                     *- returns the ara of the shape*

**`shape.centroid`**                                 *- Returns the center point of the shape*

### Modify shapes

For a complete list, see: http://geopandas.org/geometric_manipulations.html

**`shape.buffer(size)`**                             *- a circle of size around a shape*

**`shape.envelope`**                                 *- a rectangle that surrounds the shape*

**`shape1.union(shape2)`**                           *- combines two shapes*

**`gdf.unary_union`**                                *- combines all geometry in Geodataframe*

**`shape1.difference(shape2)`**                      *- subtracts shape 2 from shape1*

**`shape1.rotate()`**                                *- rotates object around itself (or other)*
- `angle=90`                                         *- by what angle*

## GEOMETRIC RELATIONS

These tests yield True/False answers and can be used with single shapes or gdf columns.

**`.within(geometry)`**                                *- test if shape is within other shape.*

**`.contains(geometry)`**                              *- test if shape contains other shape*

**`.intersects(geometry)`**                            *- test if shape intersects with other shape*

**`.touches(geometry)`**                               *- test if shape touches other shape*

**`.crosses(geometry)`**                               *- test if shape crosses other shape*

**`.disjoin(geometry)`**                               *- test if there is no spatial overlap at all*

## REARRANGING GEODATA

## Dissolving Data

**`gdf.dissolve(by='col')`**                           *- analogous to groupby for geographical data, using unary_union.* ([reference](http://geopandas.org/aggregation_with_dissolve.html))
- `aggfunc=function`                                   *- Optional, the aggregate function to use. Can be 'first', 'sum', 'mean', etc.*

### Spatial Joins

**`gpd.sjoin(gdf1, gdf2)`**                           *- sql-like join gdf2-related data to gdf1-datarows (keeps gdf1 geometry)* ([reference](http://geopandas.org/mergingdata.html))
- `how='left'/'right'/'inner'/'outer'`                *- which records to keep: same principle as in pandas*
- `op='within'`                                       *- match gdf1 shapes that are within gdf2 shapes*
- `op='contains'`                                     *- match gdf1 shapes that contain gdf2 shapes*
- `op='intersects'`                                   *- match gdf1 shapes that intersect with gdf2 shapes*

## PLOTTING

### Main function

**`gdf.plot()`**                        *- To plot any shapes defined in the geometry column*

general options:
- `markersize=5`                        *-size of point marker*
- `linewidth=0.5`                       *-thickness of borders around shapes*
- `color='lightgrey'`                   *-fill color of the shapes or points. Can be 1 color or list of colors*
- `edgecolor='white'`                   *-color of shape borders*
- `alpha=0.5`                           *-opacity of the fill colors or points*
- `zorder=n`                            *-Vertical Order*

choropleth maps:
- `column='col'`                        *-set color according to values in column 'col'*
- `cmap='map'`                          *-which colormap to use. see:* https://matplotlib.org/examples/color/colormaps_reference.html
- `scheme='quantiles'`                  *-can also be 'equal_interval', 'fisher_jenks', 'percentiles' or 'user_defined'*
- `k=5`                                 *-number of buckets (default is 5)*
- `classification_kwds={'bins': list}`  *-for 'user_defined' bins: define a list (like [2, 4, 6])*
- `legend=True`                         *-display a legend*
