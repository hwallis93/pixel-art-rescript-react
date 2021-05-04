import { createSlice, PayloadAction } from "@reduxjs/toolkit";

const white = "#ffffff";

export interface GridState {
  // The grid itself, each string is a hex colour code representing the colour of that cell
  gridRows: string[][];

  // The size of the grid in pixels. Defined here to force it to always be square rather than
  // becoming an irregular rectangle when user resizes the page
  dimension: number;
}

const initialState: GridState = {
  gridRows: Array(8).fill(Array(8).fill(white)),
  dimension: 0,
};

interface setCellColourAction {
  colour: string;
  coordinates: [number, number];
}

export const gridSlice = createSlice({
  name: "grid",
  initialState,
  reducers: {
    setSize(state, action: PayloadAction<number>) {
      const newSize = action.payload;
      const oldSize = state.gridRows.length;
      const sizeChange = newSize - oldSize;

      if (sizeChange === 0) return;

      if (sizeChange < 0) {
        console.log(`Shrinking by ${sizeChange}`);
        state.gridRows = state.gridRows.map((row) => row.slice(0, sizeChange));
        state.gridRows = state.gridRows.slice(0, sizeChange);
      }

      if (sizeChange > 0) {
        console.log(`Growing by ${sizeChange}`);

        state.gridRows = state.gridRows.map((row) =>
          row.concat(Array(sizeChange).fill(white))
        );
        Array(sizeChange)
          .fill("")
          .forEach(() => state.gridRows.push(Array(newSize).fill(white)));
      }
    },
    setCellColour(state, action: PayloadAction<setCellColourAction>) {
      const { colour, coordinates } = action.payload;
      const [row, column] = coordinates;
      state.gridRows[row][column] = colour;
    },
    setDimension(state, action: PayloadAction<number>) {
      state.dimension = action.payload;
    },
  },
});

export const { setSize, setCellColour, setDimension } = gridSlice.actions;

export default gridSlice.reducer;
