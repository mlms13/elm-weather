module Msg exposing (Msg, update)

import Data.DarkSky exposing (DarkSkyData)
import Model exposing (Model)
import RemoteData exposing (RemoteData)

type Msg
  = SetLat Float
  | SetLong Float
  | ReceiveData (RemoteData String DarkSkyData)

update : Msg -> Model -> (Model, Cmd Msg)
update msg { location, conditions } =
  case msg of
    SetLat v ->
      { location = { location | latitude = v }
      , conditions = conditions
      } ! []
    SetLong v ->
      { location = { location | longitude = v }
      , conditions = conditions
      } ! []
    ReceiveData v ->
      { location = location
      , conditions = v
      } ! []
