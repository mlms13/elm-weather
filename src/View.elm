module View exposing (view)

import Data.DarkSky exposing (DarkSkyData, DataPoint)
import Data.LatLong exposing (LatLong)
import Html exposing (..)
import Html.Attributes exposing (class)
import Maybe.Extra exposing (unwrap)
import Model exposing (Model)
import Msg exposing (Msg)
import RemoteData exposing (RemoteData(..))

view : Model -> Html Msg
view { location, conditions } =
  let
    asDataPoint : RemoteData String DataPoint
    asDataPoint =
      case conditions of
        Success v ->
          unwrap (Failure "DarkSky response does not contain current conditions") Success v.currently
        Failure msg -> Failure msg
        NotAsked -> NotAsked
        Loading -> Loading

    getColorClass : Float -> String
    getColorClass temp =
      if temp > 110 then
        "temp-extreme-hot"
      else if temp > 95 then
        "temp-very-hot"
      else if temp > 80 then
        "temp-hot"
      else if temp > 70 then
        "temp-warm"
      else if temp > 60 then
        "temp-med"
      else if temp > 45 then
        "temp-cool"
      else if temp > 30 then
        "temp-cold"
      else if temp > 15 then
        "temp-very-cold"
      else if temp > 0 then
        "temp-very-very-cold"
      else
        "temp-extreme-cold"


    globalColorClass : String
    globalColorClass =
      unwrap "temp-unknown" getColorClass <| Maybe.andThen .temperature <| RemoteData.toMaybe asDataPoint

  in
    div
      [ class <| "weather-app " ++ globalColorClass ]
      [ viewHeader location
      , viewBody asDataPoint
      ]

viewHeader : LatLong -> Html Msg
viewHeader { latitude, longitude } =
  header
    [ class "global-head" ]
    [ div
      [ class "fixed d-flex" ]
      [ h1 [] [ text "Weather" ]
      , form
        [ class "ml-auto"]
        [ input [] []
        , input [] []
        ]
      ]
    ]

viewBody : RemoteData String DataPoint -> Html a
viewBody data =
  let
    content : Html a
    content =
      case data of
        Success v ->
          viewWeather v
        Failure msg ->
          div
            [ class "alert alert-danger" ]
            [ h2 [] [ text "Something went wrong" ]
            , p [] [ text msg ]
            ]
        _ ->
          div [ class "loading-animation" ] []
  in
    div
      [ class "fixed" ]
      [ content ]

viewWeather : DataPoint -> Html a
viewWeather { temperature } =
  div [] []
