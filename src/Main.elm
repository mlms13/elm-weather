module Main exposing (main)

import Html exposing (Html)
import Model exposing (Model, init)
import Msg exposing (Msg, update, loadCurrentData)
import View exposing (view)

main : Program Never Model Msg
main =
  Html.program
    { init =
      ( init
      , loadCurrentData init
      )
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
