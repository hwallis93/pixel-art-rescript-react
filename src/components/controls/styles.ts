import styled from "styled-components";

export const ControlsContainer = styled.span`
  flex-grow: 0;
  display: flex;

  flex-direction: column;
`;
export const HexBox = styled.input``;

interface DisplayBoxProps {
  colour: string;
}
export const DisplayBox = styled.div<DisplayBoxProps>`
  background-color: ${(props) => props.colour};
`;

export const ResizeButton = styled.button`
  margin: 0px 5px 0px 5px;
`;
export const GridLinesButton = styled.button`
  margin: 5px; 0px; 5px; 0px
`;
export const ButtonsContainer = styled.span`
  justify-content: center;
  display: flex;
  width: 100%;
  padding: 5px; 0px; 5px; 0px
`;
