module Msg exposing (Msg(..), update)

import Data.DarkSky exposing (DarkSkyData)
import Model exposing (Model)
import RemoteData exposing (RemoteData)
import Request.DarkSky as ReqDarkSky exposing (getData)

type Msg
  = SetLat Float
  | SetLong Float
  | RefreshData
  | ReceiveData (RemoteData String DarkSkyData)

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ location, conditions } as model) =
  case msg of
    SetLat v ->
      let loc = { location | latitude = v }
      in { model | location = loc } ! []
    SetLong v ->
      let loc = { location | longitude = v }
      in { model | location = loc } ! []
    RefreshData ->
      (model, Cmd.map ReceiveData <| getData location)
    ReceiveData v ->
      { model | conditions = v } ! []
