module Data.WeatherCondition exposing (WeatherCondition, weatherConditionDecoder)

import Json.Decode exposing (Decoder, andThen, string, succeed)

-- used by DarkSky to indicate which icon should be used
type WeatherCondition
  = ClearDay
  | ClearNight
  | Raining -- added `ing` suffix to avoid collisions with Precipitation
  | Snowing
  | Sleeting
  | Wind
  | Fog
  | Cloudy
  | PartlyCloudyDay
  | PartlyCloudyNight
  | Unknown String
  -- not yet implemented in remote source
  -- | Hail
  -- | Thunderstorm
  -- | Tornado

weatherConditionDecoder : Decoder WeatherCondition
weatherConditionDecoder =
  let
    convert : String -> Decoder WeatherCondition
    convert raw =
      case raw of
        -- TODO
        unk -> succeed <| Unknown unk
  in
    string |> andThen convert
