@module("@reduxjs/toolkit")
external createSlice: Redux.settingsSliceArgs => Redux.slice = "createSlice"

let initialState: Redux.settingsState = {
  paintColour: "#000000",
  showGridLines: true,
}

let reducers: Redux.settingsReducers = {
  setPaintColour: (~state, ~action) => {
    state.paintColour = action.payload
  },
  toggleShowGridLines: (~state, ~action) => {
    state.showGridLines = !state.showGridLines
  },
}

let settingsSlice = createSlice({
  name: "settings",
  initialState: initialState,
  reducers: reducers,
})
