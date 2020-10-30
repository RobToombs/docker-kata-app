module Model exposing (..)

import Bootstrap.Tab as Tab
import Http
import Types exposing (VoteResult)


type alias Model =
    { dogUrl : String
    , requestError : String
    , resultTabState : Tab.State
    , highestVoted : List VoteResult
    , mostLiked : List VoteResult
    , mostDisliked : List VoteResult
    }


defaultModel : Model
defaultModel =
    Model "" "" Tab.initialState [] [] []


type Msg
    = FetchDog
    | FetchDogUrlResponse (Result Http.Error String)
    | DogApiResponse (Result Http.Error Int)
    | Like
    | Dislike
    | TabMsg Tab.State
    | GetHighestVotedResponse (Result Http.Error (List VoteResult))
    | GetMostLikedResponse (Result Http.Error (List VoteResult))
    | GetMostDislikedResponse (Result Http.Error (List VoteResult))
