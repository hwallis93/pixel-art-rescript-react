// States
type settingsState = {
  mutable paintColour: string,
  mutable showGridLines: bool,
}

type gridState = {
  mutable gridRows: array<array<string>>,
  mutable dimension: int,
}

// Actions
type action<'p> = {
  payload: 'p,
  @as("type") actionType: string,
}
type setCellColourAction = {
  colour: string,
  coordinates: (int, int),
}

// Reducers
type reducer<'s, 'p> = (~state: 's, ~action: action<'p>) => unit

type settingsReducers = {
  setPaintColour: reducer<settingsState, string>,
  toggleShowGridLines: reducer<settingsState, unit>,
}
type gridReducers = {
  setSize: reducer<gridState, int>,
  setCellColour: reducer<gridState, setCellColourAction>,
  setDimension: reducer<gridState, int>,
}

// Slices
type sliceReducer
type slice = {reducer: sliceReducer}

type gridSliceArgs = {
  name: string,
  initialState: gridState,
  reducers: gridReducers,
}
type createGridSliceSignature = gridSliceArgs => slice

type settingsSliceArgs = {
  name: string,
  initialState: settingsState,
  reducers: settingsReducers,
}
type createSettingsSliceSignature = settingsSliceArgs => slice

// Store
type store
type allReducers = {
  grid: sliceReducer,
  settings: sliceReducer,
}
type configureStoreArgs = {reducer: allReducers}
