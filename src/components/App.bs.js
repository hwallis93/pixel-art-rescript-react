// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as ReactRedux from "react-redux";
import * as Store$RescriptReactIntro from "../store/Store.bs.js";

var Provider = {};

function App(Props) {
  return React.createElement(ReactRedux.Provider, {
              store: Store$RescriptReactIntro.store,
              children: React.createElement("div", undefined, "Hi")
            });
}

var make = App;

export {
  Provider ,
  make ,
  
}
/* react Not a pure module */