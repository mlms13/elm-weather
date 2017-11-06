module Msg exposing (Msg(..), update, loadCurrentData)

import Data.DarkSky exposing (DarkSkyData)
import Data.LatLong exposing (LatLong)
import Geolocation exposing (Location)
import Model exposing (Model)
import RemoteData exposing (RemoteData)
import Request.DarkSky as ReqDarkSky exposing (getData)
import Task exposing (Task)

type Msg
  = SetLat Float
  | SetLong Float
  | SetLocation LatLong
  | RequestGeolocation
  | RefreshData
  | ReceiveData (RemoteData String DarkSkyData)

loadCurrentData : Model -> Cmd Msg
loadCurrentData { location } =
  Cmd.map ReceiveData <| getData location

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ location, conditions } as model) =
  case msg of
    SetLat v ->
      let loc = { location | latitude = v }
      in { model | location = loc } ! []
    SetLong v ->
      let loc = { location | longitude = v }
      in { model | location = loc } ! []
    SetLocation loc ->
      let updated = { model | location = loc }
      in (updated, loadCurrentData updated)

    RequestGeolocation ->
      let recover result =
        case result of
          Ok { latitude, longitude } -> SetLocation <| LatLong latitude longitude
          Err _ -> SetLocation location
      in (model, Task.attempt recover Geolocation.now)

    RefreshData ->
      (model, loadCurrentData model)
    ReceiveData v ->
      { model | conditions = v } ! []
