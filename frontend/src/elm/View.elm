module View exposing (..)

import Bootstrap.Alert exposing (simpleDanger)
import Bootstrap.Button as Button
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Tab as Tab exposing (Item)
import Bootstrap.Utilities.Spacing as Spacing
import Html exposing (Html, div, h4, img, p, text)
import Html.Attributes exposing (class, src)
import Html.Events
import Model exposing (..)
import String.Extra
import Types exposing (VoteResult)


view : Model -> Html Msg
view model =
    div []
        [ errorContainer model.requestError
        , contentContainer model
        ]


errorContainer : String -> Html msg
errorContainer error =
    if String.isEmpty error then
        div [] []

    else
        Grid.containerFluid
            [ Spacing.mt2 ]
            [ simpleDanger [] [ text error ] ]


contentContainer : Model -> Html Msg
contentContainer model =
    Grid.containerFluid []
        [ Grid.simpleRow
            [ Grid.col [] [ dogContainer model.dogUrl ]
            , Grid.col [] [ resultsContainer model ]
            ]
        ]


dogContainer : String -> Html Msg
dogContainer dogUrl =
    Grid.containerFluid []
        [ Grid.simpleRow [ Grid.col [ Col.xs4 ] [ fetchButton ] ]
        , Grid.simpleRow [ Grid.col [] [ dogVoting dogUrl ] ]
        ]


fetchButton : Html Msg
fetchButton =
    Button.button
        [ Button.primary
        , Button.attrs [ Spacing.ml2, Spacing.mt2, Spacing.mb2 ]
        , Button.onClick FetchDog
        ]
        [ text "Fetch New Dog!" ]


dogVoting : String -> Html Msg
dogVoting dogUrl =
    if String.isEmpty dogUrl then
        div [] []

    else
        div [] [ dogPicture dogUrl, votingButtons ]


dogPicture : String -> Html Msg
dogPicture dogUrl =
    img [ Spacing.ml2, class "left cap-size", src dogUrl ] []


votingButtons : Html Msg
votingButtons =
    div [ class "left" ] [ likeIcon, dislikeIcon ]


likeIcon : Html Msg
likeIcon =
    div [ Spacing.m2, class "like vote-button", Html.Events.onClick Like ] []


dislikeIcon : Html Msg
dislikeIcon =
    div [ Spacing.m2, class "dislike vote-button", Html.Events.onClick Dislike ] []


resultsContainer : Model -> Html Msg
resultsContainer model =
    div [ Spacing.m2 ]
        [ Tab.config TabMsg
            |> Tab.items
                [ createTab model.highestVoted "highestVoted" "Highest Voted"
                , createTab model.mostLiked "mostLiked" "Most Liked"
                , createTab model.mostDisliked "mostDisliked" "Most Disliked"
                ]
            |> Tab.view model.resultTabState
        ]


createTab : List VoteResult -> String -> String -> Item msg
createTab results id_ tabText =
    Tab.item
        { id = id_
        , link = Tab.link [] [ text tabText ]
        , pane =
            Tab.pane [ Spacing.mt3 ]
                [ ListGroup.ul
                    (List.map (\result -> ListGroup.li [] [ text <| String.fromInt result.count ++ " - " ++ formatBreed result.breed ]) results)
                ]
        }


formatBreed : String -> String
formatBreed breed =
    String.Extra.toTitleCase <| String.Extra.humanize breed
