type gridState = {mutable gridRows: array<array<string>>, mutable dimension: int}
type settingsState = {mutable paintColour: string, mutable showGridLines: bool}
type state = {
  grid: gridState,
  settings: settingsState,
}

type action =
  | SetPaintColour(string)
  | ToggleShowGridLines
  | SetSize(int)
  | SetCellColour({colour: string, coordinates: (int, int)})
  | SetDimension(int)

let preloadedState = {
  grid: {
    gridRows: Belt.Array.makeBy(8, _ => Belt.Array.make(8, "#ffffff")),
    dimension: 1000,
  },
  settings: {
    paintColour: "#000000",
    showGridLines: true,
  },
}

let reducer = (state, action) => {
  switch action {
  | SetPaintColour(colour) => {...state, settings: {...state.settings, paintColour: colour}}
  | ToggleShowGridLines => {
      ...state,
      settings: {...state.settings, showGridLines: !state.settings.showGridLines},
    }
  | SetDimension(dimension) => {
      ...state,
      grid: {...state.grid, dimension: dimension},
    }
  | SetCellColour({colour, coordinates}) => {
      let (row, column) = coordinates
      let gridRows = Js.Array2.copy(state.grid.gridRows)
      gridRows[row][column] = colour
      {
        ...state,
        grid: {
          ...state.grid,
          gridRows: gridRows,
        },
      }
    }
  | SetSize(newSize) => {
      let oldSize = state.grid.gridRows->Js.Array2.length
      let sizeChange = newSize - oldSize

      let gridRows = if sizeChange > 0 {
        state.grid.gridRows
        ->Js.Array2.map(row => Js.Array2.concat(row, Belt.Array.make(sizeChange, "#ffffff")))
        ->Js.Array2.concat(Belt.Array.makeBy(sizeChange, _ => Belt.Array.make(newSize, "#ffffff")))
      } else if sizeChange < 0 {
        state.grid.gridRows
        ->Js.Array2.map(row => row->Js.Array2.slice(~start=0, ~end_=sizeChange))
        ->Js.Array2.slice(~start=0, ~end_=sizeChange)
      } else {
        state.grid.gridRows->Js.Array2.copy
      }
      {...state, grid: {...state.grid, gridRows: gridRows}}
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
