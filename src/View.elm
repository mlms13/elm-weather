module View exposing (view)

import Html exposing (..)
import Model exposing (Model)
import Msg exposing (Msg)

view : Model -> Html Msg
view { location, conditions } =
  div [] []
