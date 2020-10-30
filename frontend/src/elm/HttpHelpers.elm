module HttpHelpers exposing (..)

import Http exposing (Body, Error(..), Expect, Header)
import Json.Decode as Decode


createPutExpectEntity : String -> Http.Body -> (Result Error a -> msg) -> Decode.Decoder a -> { method : String, headers : List Header, url : String, body : Body, expect : Expect msg, timeout : Maybe Float, tracker : Maybe String }
createPutExpectEntity url body callBack decoder =
    { method = "PUT"
    , headers = []
    , url = url
    , body = body
    , expect = Http.expectJson callBack decoder
    , timeout = Nothing
    , tracker = Nothing
    }


createPutExpectWhatever : String -> Http.Body -> (Result Error () -> msg) -> { method : String, headers : List Header, url : String, body : Body, expect : Expect msg, timeout : Maybe Float, tracker : Maybe String }
createPutExpectWhatever url body callBack =
    { method = "PUT"
    , headers = []
    , url = url
    , body = body
    , expect = Http.expectWhatever callBack
    , timeout = Nothing
    , tracker = Nothing
    }


createGet : String -> (Result Error a -> msg) -> Decode.Decoder a -> { url : String, expect : Expect msg }
createGet url callBack resultDecoder =
    { url = url
    , expect = Http.expectJson callBack resultDecoder
    }


createPost : String -> Http.Body -> (Result Error a -> msg) -> Decode.Decoder a -> { url : String, body : Body, expect : Expect msg }
createPost url body callBack resultDecoder =
    { url = url
    , body = body
    , expect = Http.expectJson callBack resultDecoder
    }


createPostEmpty : String -> (Result Error () -> msg) -> { url : String, body : Body, expect : Expect msg }
createPostEmpty url callBack =
    { url = url
    , body = Http.emptyBody
    , expect = Http.expectWhatever callBack
    }


errorToString : Http.Error -> String
errorToString requestError =
    case requestError of
        Timeout ->
            "Timeout exceeded"

        NetworkError ->
            "Network error"

        BadStatus status ->
            "Bad Status: " ++ String.fromInt status

        BadBody resp ->
            "Unexpected response from api: " ++ resp

        BadUrl url ->
            "Malformed url " ++ url
