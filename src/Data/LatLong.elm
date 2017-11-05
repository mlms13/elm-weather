module Data.LatLong exposing (LatLong, fromLocation)

import Geolocation exposing (Location)

type alias LatLong =
  { latitude : Float
  , longitude : Float
  }

fromLocation : Location -> LatLong
fromLocation { latitude, longitude } =
  LatLong latitude longitude
