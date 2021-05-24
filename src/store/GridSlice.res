let length = Js.Array2.length
let map = Js.Array2.map
let concat = Js.Array2.concat
let slice = Js.Array2.slice
let copy = Js.Array2.copy
let makeArray = Belt.Array.make

type state = {
  mutable gridRows: array<array<string>>,
  mutable dimension: int,
}
type action =
  | SetDimension(int)
  | SetCellColour({colour: string, coordinates: (int, int)})
  | SetSize(int)

let initialState = {
  gridRows: Belt.Array.makeBy(8, _ => makeArray(8, "#ffffff")),
  dimension: 0,
}

let reducer = (state: state, action) => {
  switch action {
  | SetDimension(dimension) => {
      ...state,
      dimension: dimension,
    }
  | SetCellColour({colour, coordinates}) => {
      let (row, column) = coordinates
      let gridRows = copy(state.gridRows)
      gridRows[row][column] = colour
      {
        ...state,
        gridRows: gridRows,
      }
    }
  | SetSize(newSize) => {
      let oldSize = state.gridRows->length
      let sizeChange = newSize - oldSize

      let gridRows = if sizeChange > 0 {
        state.gridRows
        ->map(row => row->concat(makeArray(sizeChange, "#ffffff")))
        ->concat(Belt.Array.makeBy(sizeChange, _ => makeArray(newSize, "#ffffff")))
      } else if sizeChange < 0 {
        state.gridRows
        ->map(row => row->slice(~start=0, ~end_=sizeChange))
        ->slice(~start=0, ~end_=sizeChange)
      } else {
        state.gridRows->copy
      }

      {
        ...state,
        gridRows: gridRows,
      }
    }
  }
}
