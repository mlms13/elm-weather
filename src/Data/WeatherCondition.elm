module Data.WeatherCondition exposing (WeatherCondition(..), weatherConditionDecoder, toIcon)

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

toIcon : WeatherCondition -> String
toIcon x =
  case x of
    ClearDay -> "wi-day-sunny"
    ClearNight -> "wi-night-clear"
    Raining -> "wi-rain"
    Snowing -> "wi-snow"
    Sleeting -> "wi-rain-mix"
    Wind -> "wi-strong-wind"
    Fog -> "wi-fog"
    Cloudy -> "wi-cloudy"
    PartlyCloudyDay -> "wi-day-cloudy"
    PartlyCloudyNight -> "wi-night-alt-partly-cloudy"
    Unknown _ -> "wi-na"

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
