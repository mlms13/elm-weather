module Data.MoonPhase exposing (MoonPhase)

-- new == 0, full == 0.5; floats represent in-between values
type MoonPhase
  = NewMoon
  | WaxingCrescent Float
  | FirstQuarter
  | WaxingGibbous Float
  | FullMoon
  | WaningGibbous Float
  | LastQuarter
  | WaningCrescent Float
