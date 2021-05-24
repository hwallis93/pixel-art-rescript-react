module Styles = {
  open CssJs

  let app = () =>
    style(. [
      display(#flex),
      position(#absolute),
      top(0->px),
      left(0->px),
      height(100.0->#percent),
      width(100.0->#percent),
    ])
}

module Dom = Webapi.Dom
let window = Dom.window
let document = Dom.document
let addEventListener = Dom.Window.addEventListener
let removeEventListener = Dom.Document.removeEventListener
let getElementById = Dom.Document.getElementById

@react.component
let make = () => {
  let dispatch = Redux.Store.useDispatch()

  let updateGridDimension = _ => {
    switch document |> getElementById("appContainer") {
    | Some(appContainer) => {
        let height = appContainer->Dom.Element.clientHeight
        let width = appContainer->Dom.Element.clientWidth

        let targetHeight = switch (height, width) {
        | (h, w) if h > 0 && w > 0 => Js.Math.min_int(h, w - 220)
        | _ => 0
        }

        dispatch(GridAction(SetDimension(targetHeight)))
      }
    | None => ()
    }
  }

  React.useEffect(() => {
    updateGridDimension()
    window |> addEventListener("resize", updateGridDimension)

    Some(() => document |> removeEventListener("resize", updateGridDimension))
  })

  <span className={Styles.app()} id="appContainer"> <Controls /> <Grid /> </span>
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
