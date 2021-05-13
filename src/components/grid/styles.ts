import styled from "styled-components";

interface GridContainerProps {
  cells: number;
  size: number;
}
export const GridContainer = styled.div<GridContainerProps>`
  display: grid;
  grid-auto-flow: column;
  grid-template-rows: repeat(${(props) => props.cells}, auto);
  width: ${(props) => props.size}px;
  height: ${(props) => props.size}px;
`;

let x: TemplateStringsArray = [`abc`];
styled.div([`abc`]);

interface CellContainerProps {
  colour: string;
  showBorder: boolean;
}
export const CellContainer = styled.div<CellContainerProps>`
  background-color: ${(props) => props.colour};
  border: ${(props) => (props.showBorder ? "1px dashed #666666" : "0px")};
`;
