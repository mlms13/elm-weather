module Data.DarkSky exposing (DarkSkyData, DataPoint, darkSkyDecoder)

import Data.WeatherCondition exposing (WeatherCondition, weatherConditionDecoder)
import Data.MoonPhase exposing (MoonPhase)
import Data.Precipitation exposing (Precipitation)
import Json.Decode exposing (string, float, nullable, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Time exposing (Time)

type alias DarkSkyData =
  { latitude : Float -- The requested latitude.
  , longitude : Float -- The requested longitude.
  , timezone : String -- The IANA timezone name for the requested location
  , currently : Maybe DataPoint
  -- , minutely : Maybe DataBlock
  -- , hourly : Maybe DataBlock
  -- , daily : Maybe DataBlock
  -- , alerts : List Alerts
  -- , flags : Maybe Flag
  }

type alias DataPoint =
  { apparentTemperature : Maybe Float -- The apparent (or “feels like”) temperature in degrees Fahrenheit.
  , apparentTemperatureHigh : Maybe Float -- The daytime high apparent temperature.
  , apparentTemperatureHighTime : Maybe Time -- The UNIX time representing when the daytime high apparent temperature occurs.
  , apparentTemperatureLow : Maybe Float -- The overnight low apparent temperature.
  , apparentTemperatureLowTime : Maybe Time -- The UNIX time representing when the overnight low apparent temperature occurs.
  , cloudCover : Maybe Float -- The percentage of sky occluded by clouds, between 0 and 1, inclusive.
  , dewPoint : Maybe Float -- The dew point in degrees Fahrenheit.
  , humidity : Maybe Float -- The relative humidity, between 0 and 1, inclusive.
  , icon : Maybe WeatherCondition -- capture errors to deal with potential future api changes
  -- , moonPhase : Maybe MoonPhase
  , nearestStormBearing : Maybe Float -- 0.0 is true north, degrees progressing clockwise; `Nothing` if no distance to nearest is 0
  , nearestStormDistance : Maybe Float -- The approximate distance to the nearest storm in miles.
  , ozone : Maybe Float -- The columnar density of total atmospheric ozone at the given time in Dobson units.
  , precipAccumulation : Maybe Float --The amount of snowfall accumulation expected to occur, in inches.
  , precipIntensity : Maybe Float -- The intensity (in inches of liquid water per hour) of precipitation occurring at the given time.
  , precipIntensityMax : Maybe Float -- The maximum value of precipIntensity during a given day.
  , precipIntensityMaxTime : Maybe Time -- The UNIX time of when precipIntensityMax occurs during a given day.
  , precipProbability : Maybe Float -- The probability of precipitation occurring, between 0 and 1, inclusive.
  -- , precipType : Maybe Precipitation
  , pressure : Maybe Float -- The sea-level air pressure in millibars.
  , summary : Maybe String -- A human-readable text summary of this data point.
  , sunriseTime : Maybe Time -- The UNIX time of when the sun will rise during a given day.
  , sunsetTime : Maybe Time -- The UNIX time of when the sun will set during a given day.
  , temperature : Maybe Float -- The air temperature in degrees Fahrenheit.
  , temperatureHigh : Maybe Float -- The daytime high temperature.
  , temperatureHighTime : Maybe Time -- The UNIX time representing when the daytime high temperature occurs.
  , temperatureLow : Maybe Float -- The overnight low temperature.
  , temperatureLowTime : Maybe Time -- The UNIX time representing when the overnight low temperature occurs.
  , time : Time -- The UNIX time at which this data point begins
  , uvIndex : Maybe Float -- The UV index.
  , uvIndexTime : Maybe Time -- The UNIX time of when the maximum uvIndex occurs during a given day.
  , visibility : Maybe Float -- The average visibility in miles, capped at 10 miles.
  , windBearing : Maybe Float -- The direction that the wind is coming from in degrees, with true north at 0° and progressing clockwise
  , windGust : Maybe Float -- The wind gust speed in miles per hour.
  , windSpeed : Maybe Float -- The wind speed in miles per hour.
  }

darkSkyDecoder : Decoder DarkSkyData
darkSkyDecoder =
  decode DarkSkyData
    |> required "latitude" float
    |> required "longitude" float
    |> required "timezone" string
    |> required "currently" (nullable dataPointDecoder)

dataPointDecoder : Decoder DataPoint
dataPointDecoder =
  decode DataPoint
    |> optional "apparentTemperature" (nullable float) Nothing
    |> optional "apparentTemperatureHigh" (nullable float) Nothing
    |> optional "apparentTemperatureHighTime" (nullable float) Nothing
    |> optional "apparentTemperatureLow" (nullable float) Nothing
    |> optional "apparentTemperatureLowTime" (nullable float) Nothing
    |> optional "cloudCover" (nullable float) Nothing
    |> optional "dewPoint" (nullable float) Nothing
    |> optional "humidity" (nullable float) Nothing
    |> optional "icon" (nullable weatherConditionDecoder) Nothing
    -- |> optional "moonPhase" (nullable moonPhaseDecoder) Nothing
    |> required "nearestStormBearing" (nullable float)
    |> required "nearestStormDistance" (nullable float)
    |> required "ozone" (nullable float)
    |> required "precipAccumulation" (nullable float)
    |> required "precipIntensity" (nullable float)
    |> required "precipIntensityMax" (nullable float)
    |> optional "precipIntensityMaxTime" (nullable float) Nothing
    |> required "precipProbability" (nullable float)
    -- |> optional "precipType" (nullable precipitationDecoder) Nothing
    |> required "pressure" (nullable float)
    |> optional "summary" (nullable string) Nothing
    |> optional "sunriseTime" (nullable float) Nothing
    |> optional "sunsetTime" (nullable float) Nothing
    |> required "temperature" (nullable float)
    |> required "temperatureHigh" (nullable float)
    |> optional "temperatureHighTime" (nullable float) Nothing
    |> required "temperatureLow" (nullable float)
    |> optional "temperatureLowTime" (nullable float) Nothing
    |> required "time" float
    |> required "uvIndex" (nullable float)
    |> optional "uvIndexTime" (nullable float) Nothing
    |> required "visibility" (nullable float)
    |> required "windBearing" (nullable float)
    |> required "windGust" (nullable float)
    |> required "windSpeed" (nullable float)
