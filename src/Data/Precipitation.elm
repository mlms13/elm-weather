module Data.Precipitation exposing (Precipitation)

type Precipitation
  = Rain
  | Snow
  | Sleet -- alias for "freezing rain", "ice pellets", "wintery mix"
