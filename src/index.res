module Provider = {
  @react.component @module("react-redux")
  external make: (~store: Redux.store, ~children: React.element) => React.element = "Provider"
}

switch ReactDOM.querySelector("#root") {
| None => ()
| Some(root) => ReactDOM.render(<Provider store=Store.store> <App /> </Provider>, root)
}

// import React from "react";
// import ReactDOM from "react-dom";
// import App from "./components/App";
// import { store } from "./store/store";
// import { Provider } from "react-redux";

// ReactDOM.render(
//   <React.StrictMode>
//     <Provider store={store}>
//       <App />
//     </Provider>
//   </React.StrictMode>,
//   document.getElementById("root")
// );
