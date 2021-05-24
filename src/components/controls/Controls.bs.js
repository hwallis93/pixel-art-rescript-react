// Generated by ReScript, PLEASE EDIT WITH CARE

import * as CssJs from "bs-css-emotion/src/CssJs.bs.js";
import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as ReactColor from "react-color";
import * as Redux$RescriptReactIntro from "../../store/Redux.bs.js";

function controlsContainer(param) {
  return CssJs.style([
              CssJs.flexGrow(0.0),
              CssJs.display("flex"),
              CssJs.flexDirection(CssJs.column)
            ]);
}

function buttonsContainer(param) {
  return CssJs.style([
              CssJs.justifyContent("center"),
              CssJs.display("flex"),
              CssJs.width({
                    NAME: "percent",
                    VAL: 100.0
                  }),
              CssJs.padding2(CssJs.px(5), CssJs.px(0))
            ]);
}

function resizebutton(param) {
  return CssJs.style([CssJs.margin2(CssJs.px(0), CssJs.px(5))]);
}

function gridLinesButton(param) {
  return CssJs.style([CssJs.margin2(CssJs.px(5), CssJs.px(0))]);
}

var Styles = {
  controlsContainer: controlsContainer,
  buttonsContainer: buttonsContainer,
  resizebutton: resizebutton,
  gridLinesButton: gridLinesButton
};

var SketchPicker = {};

var useSelector = Redux$RescriptReactIntro.Store.useSelector;

function pickedColour(state) {
  return state.settings.paintColour;
}

function gridSize(state) {
  return state.grid.gridRows.length;
}

function showGridLines(state) {
  return state.settings.showGridLines;
}

var words = "Right-click a cell to pick its\ncolour";

function Controls(Props) {
  var dispatch = Curry._1(Redux$RescriptReactIntro.Store.useDispatch, undefined);
  var pickedColour$1 = Curry._1(useSelector, pickedColour);
  var gridSize$1 = Curry._1(useSelector, gridSize);
  var showGridLines$1 = Curry._1(useSelector, showGridLines);
  var changeGridSize = function (change) {
    return Curry._1(dispatch, {
                TAG: /* GridAction */0,
                _0: {
                  TAG: /* SetSize */2,
                  _0: gridSize$1 + change | 0
                }
              });
  };
  var handlePickerChange = function (colour) {
    return Curry._1(dispatch, {
                TAG: /* SettingsAction */1,
                _0: /* SetPaintColour */{
                  _0: colour.hex
                }
              });
  };
  return React.createElement("span", {
              className: controlsContainer(undefined)
            }, React.createElement("span", {
                  className: buttonsContainer(undefined)
                }, React.createElement("button", {
                      className: resizebutton(undefined),
                      onClick: (function (param) {
                          return changeGridSize(1);
                        })
                    }, "+"), gridSize$1.toString(), React.createElement("button", {
                      className: resizebutton(undefined),
                      onClick: (function (param) {
                          return changeGridSize(-1);
                        })
                    }, "-")), React.createElement("button", {
                  className: gridLinesButton(undefined),
                  onClick: (function (param) {
                      return Curry._1(dispatch, {
                                  TAG: /* SettingsAction */1,
                                  _0: /* ToggleShowGridLines */0
                                });
                    })
                }, showGridLines$1 ? "Hide grid lines" : "Show grid lines"), React.createElement(ReactColor.SketchPicker, {
                  color: pickedColour$1,
                  onChangeComplete: handlePickerChange
                }), React.createElement("pre", undefined, words));
}

var make = Controls;

export {
  Styles ,
  SketchPicker ,
  useSelector ,
  pickedColour ,
  gridSize ,
  showGridLines ,
  words ,
  make ,
  
}
/* CssJs Not a pure module */
