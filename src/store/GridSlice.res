let white = "#ffffff"
@module("@reduxjs/toolkit") external createSlice: Redux.gridSliceArgs => Redux.slice = "createSlice"

let map = Js.Array2.map
let slice = Js.Array2.slice
let makeArray = Belt.Array.make

let initialState: Redux.gridState = {
  gridRows: makeArray(8, makeArray(8, white)),
  dimension: 0,
}

let reducers: Redux.gridReducers = {
  setSize: (~state, ~action) => {
    let newSize = action.payload
    let oldSize = state.gridRows->Js.Array2.length
    let sizeChange = newSize - oldSize

    if sizeChange > 0 {
      Js.log(`Growing by ${Js.Int.toString(sizeChange)}`)

      let growRow = (row: array<string>): array<string> => {
        let newEntries = makeArray(sizeChange, white)
        row->Js.Array2.concat(newEntries)
      }

      state.gridRows = state.gridRows->map(row => growRow(row))
    }
    if sizeChange < 0 {
      Js.log(`Shrinking by ${Js.Int.toString(sizeChange)}`)
      state.gridRows = state.gridRows->map(row => row->slice(~start=0, ~end_=sizeChange))
      state.gridRows = state.gridRows->slice(~start=0, ~end_=sizeChange)
    }
  },
  setCellColour: (~state, ~action) => {
    let {colour, coordinates: (row, column)} = action.payload
    state.gridRows[row][column] = colour
  },
  setDimension: (~state, ~action) => state.dimension = action.payload,
}

let gridSlice = createSlice({
  name: "grid",
  initialState: initialState,
  reducers: reducers,
})
