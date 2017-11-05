module Model exposing (Model, init)

import Data.LatLong exposing (LatLong, fromLocation)
import Data.DarkSky exposing (DarkSkyData)
import RemoteData exposing (RemoteData(..))

type alias Model =
  { location : LatLong
  , conditions : RemoteData String DarkSkyData
  }

init : Model
init =
  { location = LatLong 40.0150 -105.2705
  , conditions = NotAsked
  }
