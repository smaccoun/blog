module Pages.Welcome exposing (..)

import Bulma.Elements as Elements
import Bulma.Layout exposing (..)
import Bulma.Modifiers exposing (Size(..))
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (href, style, target)
import Link
import RemoteData exposing (RemoteData(..), WebData)
import Server.Config as SC
import Server.RequestUtils exposing (getRequestString)


type alias Model =
    { context : SC.Context
    , response : WebData String
    }


init : SC.Context -> ( Model, Cmd Msg )
init context =
    ( { context = context, response = NotAsked }
    , Cmd.map ReceiveResponse
        (getRequestString context "health"
            |> RemoteData.sendRequest
        )
    )


type Msg
    = ReceiveResponse (WebData String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveResponse response ->
            { model | response = response } ! []


viewWelcomeScreen : Model -> Html msg
viewWelcomeScreen { context, response } =
    div []
        [ section NotSpaced
            []
            [ Elements.title Elements.H2 [] [ text "Steven MacCoun" ]
            , a [ href "/blogPost" ] [ text <| "Blog " ]
            ]
        ]
