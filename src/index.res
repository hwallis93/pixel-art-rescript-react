switch ReactDOM.querySelector("#root") {
| None => ()
| Some(root) =>
  ReactDOM.render(<Redux.Store.Provider store=Redux.store> <App /> </Redux.Store.Provider>, root)
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
