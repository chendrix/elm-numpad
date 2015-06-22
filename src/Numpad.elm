module Numpad
  ( numpad
  ) where

{-| Library for working with a numpad.

```
7 8 9
4 5 6
1 2 3
```

@docs numpad

-}

import Keyboard exposing (KeyCode)
import Signal exposing (Signal)
import Dict exposing (Dict)
import Maybe

type alias Direction =
  { x: Int, y: Int }

numCodes : Dict KeyCode Direction
numCodes =
  Dict.fromList
    [ (49, { x =-1, y =-1 })
    , (50, { x = 0, y =-1 })
    , (51, { x = 1, y =-1 })
    , (52, { x =-1, y = 0 })
    , (54, { x = 1, y = 0 })
    , (55, { x =-1, y = 1 })
    , (56, { x = 0, y = 1 })
    , (57, { x = 1, y = 1 })
    ]

toXY : Keyboard.KeyCode -> Direction
toXY code =
  Dict.get code numCodes
  |> Maybe.withDefault { x = 0, y = 0 }

-- PUBLIC API

{-| A signal of records indicating the directionality of which number is pressed.
  * `{ x =-1, y = 1 }`: 7 (up-left)
  * `{ x = 0, y = 1 }`: 8 (up)
  * `{ x = 1, y = 1 }`: 9 (up-right)
  * `{ x =-1, y = 0 }`: 6 (left)
  * `{ x = 0, y = 0 }`: 5 (center)
  * `{ x = 0, y = 1 }`: 4 (right)
  * `{ x =-1, y =-1 }`: 1 (down-left)
  * `{ x = 0, y =-1 }`: 2 (down)
  * `{ x = 1, y =-1 }`: 3 (down-right)
-}
numpad : Signal { x:Int, y:Int }
numpad =
  Signal.map toXY Keyboard.presses

