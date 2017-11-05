module Main exposing (main)

import Html exposing (Html)
import Model exposing (Model, init)
import Msg exposing (Msg, update)
import View exposing (view)

main : Program Never Model Msg
main =
  Html.program
    { init = (init, Cmd.none)
    , view = view
    , update = update
    , subscriptions = always Sub.none
    }
