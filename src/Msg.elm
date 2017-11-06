module Msg exposing (Msg(..), update, loadCurrentData)

import Data.DarkSky exposing (DarkSkyData)
import Data.LatLong exposing (LatLong)
import Geolocation exposing (Location)
import Model exposing (Model)
import RemoteData exposing (RemoteData)
import Request.DarkSky as ReqDarkSky exposing (getData)
import Round exposing (roundNum)
import Task exposing (Task)

type Msg
  = SetLat Float
  | SetLong Float
  | SetLocation LatLong
  | RequestGeolocation
  | ReceiveData (RemoteData String DarkSkyData)

loadCurrentData : Model -> Cmd Msg
loadCurrentData { location } =
  Cmd.map ReceiveData <| getData location

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ location, conditions } as model) =
  case msg of
    SetLat v ->
      let
        loc = { location | latitude = clamp -90 90 v }
        updated = { model | location = loc }
      in updated ! [ loadCurrentData updated ]
    SetLong v ->
      let
        loc = { location | longitude = clamp -180 180 v }
        updated = { model | location = loc }
      in updated ! [ loadCurrentData updated ]
    SetLocation loc ->
      let updated = { model | location = loc }
      in (updated, loadCurrentData updated)

    RequestGeolocation ->
      let recover result =
        case result of
          Ok { latitude, longitude } ->
            SetLocation <| LatLong (roundNum 3 latitude) (roundNum 3 longitude)
          Err _ ->
            SetLocation location -- ignore error, no change in model
      in (model, Task.attempt recover Geolocation.now)

    ReceiveData v ->
      { model | conditions = v } ! []
