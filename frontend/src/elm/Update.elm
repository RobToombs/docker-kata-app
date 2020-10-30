module Update exposing (..)

import HttpActions exposing (getDogPicture, getHighestVoted, getMostDisliked, getMostLiked, putDislikeDog, putLikeDog, putStoreDogUrl)
import HttpHelpers exposing (errorToString)
import Model exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchDog ->
            ( model, getDogPicture )

        FetchDogUrlResponse result ->
            case result of
                Ok dogUrl_ ->
                    ( { model | dogUrl = dogUrl_ }, putStoreDogUrl dogUrl_ )

                Err _ ->
                    ( model, Cmd.none )

        Like ->
            let
                commands =
                    Cmd.batch
                        [ putLikeDog model.dogUrl
                        , getDogPicture
                        ]
            in
            ( model, commands )

        Dislike ->
            let
                commands =
                    Cmd.batch
                        [ putDislikeDog model.dogUrl
                        , getDogPicture
                        ]
            in
            ( model, commands )

        DogApiResponse result ->
            let
                commands =
                    Cmd.batch
                        [ getHighestVoted
                        , getMostLiked
                        , getMostDisliked
                        ]
            in
            case result of
                Ok id ->
                    ( { model | requestError = "" }, commands )

                Err err ->
                    let
                        requestError_ =
                            errorToString err
                    in
                    ( { model | requestError = requestError_ }, commands )

        TabMsg newState ->
            ( { model | resultTabState = newState }, Cmd.none )

        GetHighestVotedResponse result ->
            case result of
                Ok highestVoted_ ->
                    ( { model | highestVoted = highestVoted_ }, Cmd.none )

                Err err ->
                    let
                        requestError_ =
                            errorToString err
                    in
                    ( { model | requestError = requestError_ }, Cmd.none )

        GetMostLikedResponse result ->
            case result of
                Ok mostLiked_ ->
                    ( { model | mostLiked = mostLiked_ }, Cmd.none )

                Err err ->
                    let
                        requestError_ =
                            errorToString err
                    in
                    ( { model | requestError = requestError_ }, Cmd.none )

        GetMostDislikedResponse result ->
            case result of
                Ok mostDisliked_ ->
                    ( { model | mostDisliked = mostDisliked_ }, Cmd.none )

                Err err ->
                    let
                        requestError_ =
                            errorToString err
                    in
                    ( { model | requestError = requestError_ }, Cmd.none )
