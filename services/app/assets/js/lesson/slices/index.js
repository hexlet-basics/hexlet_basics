// @ts-check

import { combineReducers } from 'redux';

import checkInfo, { actions as checkInfoActions } from './checkInfo';
import currentTabInfo, { actions as currentTabInfoActions } from './currentTabInfo';
import lessonState, { actions as lessonActions } from './lessonState';
import solutionState, { actions as solutionActions } from './solutionState';
import editor, { actions as editorActions } from './editor';

export default combineReducers({
  editor,
  checkInfo,
  currentTabInfo,
  lessonState,
  solutionState,
});

const actions = {
  ...editorActions,
  ...checkInfoActions,
  ...lessonActions,
  ...solutionActions,
  ...currentTabInfoActions,
};

export {
  actions,
};
