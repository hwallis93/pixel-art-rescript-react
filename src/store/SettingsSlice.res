type state = {
  mutable paintColour: string,
  mutable showGridLines: bool,
}
type action =
  | SetPaintColour(string)
  | ToggleShowGridLines

let initialState = {
  paintColour: "#000000",
  showGridLines: true,
}

let reducer = (state, action) => {
  switch action {
  | SetPaintColour(colour) => {
      ...state,
      paintColour: colour,
    }
  | ToggleShowGridLines => {
      ...state,
      showGridLines: !state.showGridLines,
    }
  }
}
