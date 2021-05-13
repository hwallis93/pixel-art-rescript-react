// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Toolkit from "@reduxjs/toolkit";
import * as GridSlice$RescriptReactIntro from "./GridSlice.bs.js";
import * as SettingsSlice$RescriptReactIntro from "./SettingsSlice.bs.js";

var store = Toolkit.configureStore({
      reducer: {
        grid: GridSlice$RescriptReactIntro.gridSlice.reducer,
        settings: SettingsSlice$RescriptReactIntro.settingsSlice.reducer
      }
    });

export {
  store ,
  
}
/* store Not a pure module */