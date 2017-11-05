module Model exposing (Model, init)

import Data.LatLong exposing (LatLong, fromLocation)
import Data.DarkSky exposing (DarkSkyData)
import RemoteData exposing (RemoteData(..))

type alias Model =
  { location : LatLong
  , conditions : RemoteData String DarkSkyData
  , apiKey : String
  }

init : Model
init =
  { location = LatLong 40.015 -105.27
  , conditions = NotAsked
  , apiKey = "" -- TODO
  }
