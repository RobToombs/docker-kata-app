module HttpActions exposing (..)

import Http
import HttpHelpers exposing (createGet, createPutExpectEntity)
import Json.Decode as Decode exposing (Decoder, field, string)
import Json.Decode.Pipeline exposing (required)
import Json.Encode as Encode
import Model exposing (Msg(..))
import Types exposing (VoteResult)


getDogPicture : Cmd Msg
getDogPicture =
    let
        url =
            "https://dog.ceo/api/breeds/image/random"
    in
    Http.get <| createGet url FetchDogUrlResponse dogUrlDecoder


putStoreDogUrl : String -> Cmd Msg
putStoreDogUrl dogUrl =
    let
        url =
            "/api/dog/store"

        body =
            Encode.string dogUrl |> Http.jsonBody
    in
    Http.request <| createPutExpectEntity url body DogApiResponse Decode.int


putLikeDog : String -> Cmd Msg
putLikeDog dogUrl =
    let
        url =
            "/api/dog/like"

        body =
            Encode.string dogUrl |> Http.jsonBody
    in
    Http.request <| createPutExpectEntity url body DogApiResponse Decode.int


putDislikeDog : String -> Cmd Msg
putDislikeDog dogUrl =
    let
        url =
            "/api/dog/dislike"

        body =
            Encode.string dogUrl |> Http.jsonBody
    in
    Http.request <| createPutExpectEntity url body DogApiResponse Decode.int


getHighestVoted : Cmd Msg
getHighestVoted =
    let
        url =
            "/api/dog/highest-voted"
    in
    Http.get <| createGet url GetHighestVotedResponse decodeVoteResults


getMostLiked : Cmd Msg
getMostLiked =
    let
        url =
            "/api/dog/most-liked"
    in
    Http.get <| createGet url GetMostLikedResponse decodeVoteResults


getMostDisliked : Cmd Msg
getMostDisliked =
    let
        url =
            "/api/dog/most-disliked"
    in
    Http.get <| createGet url GetMostDislikedResponse decodeVoteResults


dogUrlDecoder : Decoder String
dogUrlDecoder =
    field "message" string


decodeVoteResults : Decoder (List VoteResult)
decodeVoteResults =
    Decode.list decodeVoteResult


decodeVoteResult : Decoder VoteResult
decodeVoteResult =
    Decode.succeed VoteResult
        |> required "breed" Decode.string
        |> required "count" Decode.int
