import { createSlice, PayloadAction } from "@reduxjs/toolkit";

const black = "#000000";

export interface SettingsState {
  // The colour to fill a cell with when clicking it
  paintColour: string;

  // Whether to show dashed lines between cells in the grid
  showGridLines: boolean;
}

const initialState: SettingsState = {
  paintColour: black,
  showGridLines: true,
};

export const settingsSlice = createSlice({
  name: "settings",
  initialState,
  reducers: {
    setPaintColour(state, action: PayloadAction<string>) {
      state.paintColour = action.payload;
    },
    toggleShowGridLines(state) {
      state.showGridLines = !state.showGridLines;
    },
  },
});

export const { setPaintColour, toggleShowGridLines } = settingsSlice.actions;

export default settingsSlice.reducer;
