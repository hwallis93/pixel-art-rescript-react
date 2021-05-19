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

type element = {
  clientHeight: option<int>,
  clientWidth: option<int>,
}
type document = {getElementById: (. string) => Js.Nullable.t<element>}
@val external document: document = "document"

@react.component
let make = () => {
  let dispatch = Redux.Store.useDispatch()
  // TODO shrink this logic?
  let updateGridDimension = _ => {
    switch document.getElementById(. "appContainer")->Js.Nullable.toOption {
    | Some(appContainer) => {
        let height = appContainer.clientHeight
        let width = appContainer.clientWidth
        let targetHeight = switch (height, width) {
        | (Some(h), Some(w)) => Js.Math.min_int(h, w - 220)
        | _ => 0
        }
        dispatch(SetDimension(targetHeight))
      }
    | None => ()
    }
  }

  React.useEffect(() => {
    updateGridDimension()
    Webapi.Dom.window |> Webapi.Dom.Window.addEventListener("resize", updateGridDimension)
    Some(
      () =>
        Webapi.Dom.document |> Webapi.Dom.Document.removeEventListener(
          "resize",
          updateGridDimension,
        ),
    )
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
