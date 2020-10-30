module Main exposing (..)

import Browser
import Model exposing (Model, Msg, defaultModel)
import Update exposing (update)
import View exposing (view)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( defaultModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
