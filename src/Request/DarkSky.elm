module Request.DarkSky exposing (getData)

import Data.DarkSky exposing (DarkSkyData, darkSkyDecoder)
import Data.LatLong exposing (LatLong)
import Http exposing (getString)
import Json.Decode exposing (decodeString)
import RemoteData exposing (RemoteData(..), WebData, sendRequest, fromResult)

baseUrl : String
baseUrl = "https://api.darksky.net/forecast"

getData : String -> LatLong -> Cmd (RemoteData String DarkSkyData)
getData apiKey { latitude, longitude } =
  let
    url : String
    url =
      baseUrl ++ "/" ++ apiKey ++ "/" ++ (toString latitude) ++ "," ++ (toString longitude)

    parseResponse : WebData String -> RemoteData String DarkSkyData
    parseResponse data =
      case data of
        NotAsked -> NotAsked
        Loading -> Loading
        Failure e -> Failure <| toString e
        Success str -> fromResult <| decodeString darkSkyDecoder str
  in
    (Cmd.map parseResponse) << sendRequest
      <| getString url
