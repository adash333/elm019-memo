module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, br, button, div, h1, img, input, li, section, table, td, text, tr, ul)
import Html.Attributes exposing (class, disabled, placeholder, src, value)
import Html.Events exposing (onInput, onSubmit)



---- MODEL ----


type alias Model =
    { input : String
    , memos : List String
    }


init : ( Model, Cmd Msg )
init =
    ( { input = "", memos = [] }, Cmd.none )



---- UPDATE ----


type Msg
    = Input String
    | Submit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input input ->
            -- 入力文字列を更新する
            ( { model | input = input }, Cmd.none )

        Submit ->
            ( { model
                -- 入力文字列をリセットする
                | input = ""

                -- 最新のメモを追加する
                , memos = model.input :: model.memos
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    section [ class "section" ]
        [ div [ class "container" ]
            [ h1 [] [ text "Elm Memo" ]
            , img [ src "/logo.svg" ] []
            , br [] []
            , div [ class "columns is-mobile is-centered" ]
                [ div [ class "column is-three-quarters-mobile is-half-tablet " ]
                    [ div [ class "field" ]
                        [ div [ class "control" ]
                            [ Html.form [ onSubmit Submit ]
                                [ input [ class "input is-primary", placeholder "memo", value model.input, onInput Input ] [] ]
                            ]
                        ]
                    ]
                ]
                        , div [ class "card" ]
                [ div [ class "card-content" ]
                    [ table [ class "table is-striped is-fullwidth" ]
                        (List.map viewMemo model.memos)
                    ]
                ]
            ]
        ]


viewMemo : String -> Html Msg
viewMemo memo =
    tr [] [ td [] [ text memo ] ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
