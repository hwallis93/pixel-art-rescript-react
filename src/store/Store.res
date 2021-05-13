@module("@reduxjs/toolkit")
external configureStore: Redux.configureStoreArgs => Redux.store = "configureStore"

let store = configureStore({
  reducer: {
    grid: GridSlice.gridSlice.reducer,
    settings: SettingsSlice.settingsSlice.reducer,
  },
})
