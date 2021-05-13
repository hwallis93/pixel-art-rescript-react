// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as ReactDom from "react-dom";
import * as ReactRedux from "react-redux";
import * as App$RescriptReactIntro from "./components/App.bs.js";
import * as Store$RescriptReactIntro from "./store/Store.bs.js";

var Provider = {};

var root = document.querySelector("#root");

if (!(root == null)) {
  ReactDom.render(React.createElement(ReactRedux.Provider, {
            store: Store$RescriptReactIntro.store,
            children: React.createElement(App$RescriptReactIntro.make, {})
          }), root);
}

export {
  Provider ,
  
}
/* root Not a pure module */
