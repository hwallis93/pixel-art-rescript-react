import { configureStore, ThunkAction, Action } from "@reduxjs/toolkit";
import gridReducer from "./gridSlice";
import settingsReducer from "./settingsSlice";

export const store = configureStore({
  reducer: {
    grid: gridReducer,
    settings: settingsReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
