type state = {
  grid: GridSlice.state,
  settings: SettingsSlice.state,
}

let preloadedState = {
  grid: GridSlice.initialState,
  settings: SettingsSlice.initialState,
}

type action =
  | GridAction(GridSlice.action)
  | SettingsAction(SettingsSlice.action)

let reducer = (state, action) => {
  switch action {
  | GridAction(gridAction) => {
      ...state,
      grid: GridSlice.reducer(state.grid, gridAction),
    }
  | SettingsAction(settingsAction) => {
      ...state,
      settings: SettingsSlice.reducer(state.settings, settingsAction),
    }
  }
}

let store: Reductive.Store.t<action, state> = Reductive.Store.create(~reducer, ~preloadedState, ())

module Store = {
  include ReductiveContext.Make({
    type action = action
    type state = state
  })
}
