module Data.WeatherCondition exposing (WeatherCondition, weatherConditionDecoder)

import Json.Decode exposing (Decoder, map, string, succeed)

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
    convert : String -> WeatherCondition
    convert raw =
      case raw of
        "clear-day" -> ClearDay
        "clear-night" -> ClearNight
        "rain" -> Raining
        "snow" -> Snowing
        "sleet" -> Sleeting
        "wind" -> Wind
        "fog" -> Fog
        "cloudy" -> Cloudy
        "partly-cloudy-day" -> PartlyCloudyDay
        "partly-cloudy-night" -> PartlyCloudyNight
        unk -> Unknown unk
  in
    string |> map convert
