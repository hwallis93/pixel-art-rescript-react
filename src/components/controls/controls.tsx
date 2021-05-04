import React from "react";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "../../store/store";
import { setSize } from "../../store/gridSlice";
import {
  ControlsContainer,
  ResizeButton,
  ButtonsContainer,
  GridLinesButton,
} from "./styles";

import { ColorResult, SketchPicker } from "react-color";
import { setPaintColour, toggleShowGridLines } from "../../store/settingsSlice";

const words: string = `Right-click a cell to pick its
colour`;

export const Controls = () => {
  const dispatch = useDispatch();
  const pickedColour = useSelector<RootState, string>(
    (state) => state.settings.paintColour
  );
  const gridSize = useSelector<RootState, number>(
    (state) => state.grid.gridRows.length
  );
  const showGridLines = useSelector<RootState, boolean>(
    (state) => state.settings.showGridLines
  );

  const handlePickerChange = (colour: ColorResult) => {
    dispatch(setPaintColour(colour.hex));
  };

  const changeGridSize = (change: number) =>
    dispatch(setSize(gridSize + change));

  return (
    <ControlsContainer>
      <ButtonsContainer>
        <ResizeButton onClick={() => changeGridSize(1)}>+</ResizeButton>
        {gridSize}
        <ResizeButton onClick={() => changeGridSize(-1)}>-</ResizeButton>
      </ButtonsContainer>
      <GridLinesButton onClick={() => dispatch(toggleShowGridLines())}>
        {showGridLines ? "Hide grid lines" : "Show grid lines"}
      </GridLinesButton>
      <SketchPicker
        color={pickedColour}
        onChangeComplete={handlePickerChange}
      />
      <pre>{words}</pre>
    </ControlsContainer>
  );
};
