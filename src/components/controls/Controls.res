module Styles = {
  open CssJs

  let controlsContainer = () => style(. [flexGrow(0.0), display(#flex), flexDirection(column)])
  let buttonsContainer = () =>
    style(. [
      justifyContent(#center),
      display(#flex),
      width(100.0->#percent),
      padding2(~h=0->px, ~v=5->px),
    ])
  let resizebutton = () => style(. [margin2(~h=5->px, ~v=0->px)])
  let gridLinesButton = () => style(. [margin2(~h=0->px, ~v=5->px)])
}

module SketchPicker = {
  type colorResult = {hex: string}
  @module("react-color") @react.component
  external make: (~color: string, ~onChangeComplete: colorResult => unit) => React.element =
    "SketchPicker"
}

type state = Redux.state
let useSelector = Redux.Store.useSelector
let pickedColour = (state: state) => state.settings.paintColour
let gridSize = (state: state) => state.grid.gridRows->Js.Array2.length
let showGridLines = (state: state) => state.settings.showGridLines

let words = React.string(`Right-click a cell to pick its
colour`)

@react.component
let make = () => {
  let dispatch = Redux.Store.useDispatch()

  let pickedColour = useSelector(pickedColour)
  let gridSize = useSelector(gridSize)
  let showGridLines = useSelector(showGridLines)

  let changeGridSize = (change: int) => dispatch(GridAction(SetSize(gridSize + change)))
  let handlePickerChange = (colour: SketchPicker.colorResult) =>
    dispatch(SettingsAction(SetPaintColour(colour.hex)))

  <span className={Styles.controlsContainer()}>
    <span className={Styles.buttonsContainer()}>
      <button className={Styles.resizebutton()} onClick={_ => changeGridSize(1)}>
        {React.string("+")}
      </button>
      {React.string(gridSize->Js.Int.toString)}
      <button className={Styles.resizebutton()} onClick={_ => changeGridSize(-1)}>
        {React.string("-")}
      </button>
    </span>
    <button
      className={Styles.gridLinesButton()}
      onClick={_ => dispatch(SettingsAction(ToggleShowGridLines))}>
      {showGridLines ? React.string("Hide grid lines") : React.string("Show grid lines")}
    </button>
    <SketchPicker color={pickedColour} onChangeComplete={handlePickerChange} />
    <pre> words </pre>
  </span>
}
