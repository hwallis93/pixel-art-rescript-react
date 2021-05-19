module Styles = {
  open CssJs

  let cellContainer = (~colour: string, ~showBorder: bool) => {
    let border = if showBorder {
      border(1->px, #dashed, "666666"->hex)
    } else {
      border(0->px, #dashed, #transparent)
    }
    style(. [backgroundColor(colour->Js.String2.replace("#", "")->hex), border])
  }

  let gridContainer = (~cells: int, ~size: int) => {
    style(. [
      display(#grid),
      gridAutoFlow(#column),
      gridTemplateRows([#repeat(#num(cells), #auto)]),
      width(size->px),
      height(size->px),
    ])
  }
}

type state = Redux.state
let useSelector = Redux.Store.useSelector

module Cell = {
  let pickedColour = (state: state) => state.settings.paintColour
  let showBorder = (state: state) => state.settings.showGridLines

  @react.component
  let make = (~colour: string, ~coordinates: (int, int)) => {
    let dispatch = Redux.Store.useDispatch()

    let pickedColour = useSelector(pickedColour)
    let showBorder = useSelector(showBorder)

    let handleClick = _ => dispatch(SetCellColour({colour: pickedColour, coordinates: coordinates}))

    let handleRightClick = (event: ReactEvent.Mouse.t) => {
      event->ReactEvent.Mouse.preventDefault
      dispatch(SetPaintColour(colour))
    }
    <div
      className={Styles.cellContainer(~colour, ~showBorder)}
      onClick={handleClick}
      onContextMenu={handleRightClick}
    />
  }
}

let gridCells = (state: state) => state.grid.gridRows
let gridDimension = (state: state) => state.grid.dimension

@react.component
let make = () => {
  let gridCells = useSelector(gridCells)
  let gridDimension = useSelector(gridDimension)

  <div className={Styles.gridContainer(~cells=gridCells->Js.Array2.length, ~size=gridDimension)}>
    {React.array(
      gridCells->Js.Array2.mapi((row, rowIndex) => {
        React.array(
          row->Js.Array2.mapi((cell, colIndex) => {
            <Cell colour={cell} coordinates={(rowIndex, colIndex)} />
          }),
        )
      }),
    )}
  </div>
}

// import React from "react";
// import { useDispatch, useSelector } from "react-redux";
// import { RootState } from "../../store/store";
// import { setCellColour } from "../../store/gridSlice";

// import { CellContainer, GridContainer } from "./styles";
// import { setPaintColour } from "../../store/settingsSlice";

// function Grid() {
//   const gridCells = useSelector<RootState, string[][]>(
//     (state) => state.grid.gridRows
//   );
//   const gridDimension = useSelector<RootState, number>(
//     (state) => state.grid.dimension
//   );

//   if (gridDimension === 0) return null;

//   return (
//     <GridContainer
//       cells={gridCells.length}
//       id="gridContainer"
//       size={gridDimension}
//     >
//       {gridCells.map((row, rowIndex) =>
//         row.map((cell, colIndex) => (
//           <Cell colour={cell} coordinates={[rowIndex, colIndex]} />
//         ))
//       )}
//     </GridContainer>
//   );
// }

// interface CellProps {
//   colour: string;
//   coordinates: [number, number];
// }
// function Cell({ colour, coordinates }: CellProps) {
//   const dispatch = useDispatch();
//   const pickedColour = useSelector<RootState, string>(
//     (state) => state.settings.paintColour
//   );
//   const showBorder = useSelector<RootState, boolean>(
//     (state) => state.settings.showGridLines
//   );
//   const handleClick = () => {
//     dispatch(setCellColour({ colour: pickedColour, coordinates }));
//   };
//   const handleRightClick = (event: React.MouseEvent<HTMLDivElement>) => {
//     event.preventDefault();
//     dispatch(setPaintColour(colour));
//   };
//   return (
//     <CellContainer
//       colour={colour}
//       onClick={handleClick}
//       onContextMenu={handleRightClick}
//       showBorder={showBorder}
//     ></CellContainer>
//   );
// }

// export default Grid;
