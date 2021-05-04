import React from "react";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../store/store";
import { setCellColour } from "../../store/gridSlice";

import { CellContainer, GridContainer } from "./styles";
import { setPaintColour } from "../../store/settingsSlice";

interface CellProps {
  colour: string;
  coordinates: [number, number];
}
function Cell({ colour, coordinates }: CellProps) {
  const dispatch = useDispatch();
  const pickedColour = useSelector<RootState, string>(
    (state) => state.settings.paintColour
  );
  const showBorder = useSelector<RootState, boolean>(
    (state) => state.settings.showGridLines
  );
  const handleClick = () => {
    dispatch(setCellColour({ colour: pickedColour, coordinates }));
  };
  const handleRightClick = (event: React.MouseEvent<HTMLDivElement>) => {
    event.preventDefault();
    dispatch(setPaintColour(colour));
  };
  return (
    <CellContainer
      colour={colour}
      onClick={handleClick}
      onContextMenu={handleRightClick}
      showBorder={showBorder}
    ></CellContainer>
  );
}

function Grid() {
  const gridCells = useSelector<RootState, string[][]>(
    (state) => state.grid.gridRows
  );
  const gridDimension = useSelector<RootState, number>(
    (state) => state.grid.dimension
  );

  if (gridDimension === 0) return null;

  return (
    <GridContainer
      cells={gridCells.length}
      id="gridContainer"
      size={gridDimension}
    >
      {gridCells.map((row, rowIndex) =>
        row.map((cell, colIndex) => (
          <Cell colour={cell} coordinates={[rowIndex, colIndex]} />
        ))
      )}
    </GridContainer>
  );
}

export default Grid;
