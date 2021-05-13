module Provider = {
  @react.component @module("react-redux")
  external make: (~store: Redux.store, ~children: React.element) => React.element = "Provider"
}

@react.component
let make = () => {
  <Provider store=Store.store> <div> {React.string("Hi")} </div> </Provider>
}

// import React, { useEffect } from "react";
// import { useDispatch } from "react-redux";
// import { setDimension } from "../store/gridSlice";
// import { Controls } from "./controls/controls";
// import Grid from "./grid/grid";

// import { AppContainer } from "./styles";

// function App() {
//   const dispatch = useDispatch();

//   function updateGridDimension() {
//     const appContainer = document.getElementById("appContainer");
//     const height = appContainer?.clientHeight;
//     const width = appContainer?.clientWidth;

//     let targetHeight: number;

//     if (height !== undefined && width !== undefined) {
//       // 220px is the (fixed) width of the colour picker component
//       targetHeight = Math.min(height, width - 220);
//     } else {
//       targetHeight = 0;
//     }
//     dispatch(setDimension(targetHeight));
//   }

//   // The grid must always be square. We can't calculate what dimension this square should have until
//   // after first render since before then we can't be sure how much space the Component will have
//   useEffect(() => {
//     updateGridDimension();
//     window.addEventListener("resize", updateGridDimension);
//     return () => document.removeEventListener("resize", updateGridDimension);
//   });

//   return (
//     <AppContainer id="appContainer">
//       <Controls />
//       <Grid />
//     </AppContainer>
//   );
// }

// export default App;
