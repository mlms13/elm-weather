module Data.WeatherCondition exposing (WeatherCondition, WeatherConditionParseError)

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
  -- not yet implemented in remote source
  -- | Hail
  -- | Thunderstorm
  -- | Tornado

type WeatherConditionParseError
  = Missing
  | UnknownValue String
