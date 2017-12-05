import { combineReducers } from 'redux';
import { handleActions } from 'redux-actions';

import * as actions from '../actions';

const consoleIndex = 1;
const editorIndex = 0;

const code = handleActions({
  [actions.changeCode]: (state, { payload }) => {
    const { content } = payload;
    return content;
  },
}, '');

const currentTabInfo = handleActions({
  [actions.runCheckRequest]: (state) => {
    const newState = { ...state, index: consoleIndex };
    return newState;
  },
  [actions.selectTab]: (state, { payload }) => {
    const { index } = payload;
    const newClicksCount = state.index === index ? state.clicksCount + 1 : 0;
    return { index, clicksCount: newClicksCount };
  },
}, { index: editorIndex, clicksCount: 0 });

const notification = handleActions({
  [actions.dismissNotification]: () => {
    const info = null;
    return info;
  },
  [actions.runCheckFailure]: () => {
    const info = { type: 'danger', message: 'something was wrong, try one more time' };
    return info;
  },
  [actions.runCheckRequest]: () => {
    const info = null;
    return info;
  },
  [actions.runCheckSuccess]: (state, { payload }) => {
    const info = { type: 'success', message: 'Whoa! You did it! Go next.' };
    return info;
  },
}, null);

const checkInfo = handleActions({
  [actions.runCheckRequest]: (state) => {
    const newState = { ...state, processing: true };
    return newState;
  },
  [actions.runCheckSuccess]: (state, { payload }) => {
    const { data: { attributes } } = payload.responseObject;
    const newOutputs = [...state.outputs, attributes.output];
    return {
      ...state,
      processing: false,
      outputs: newOutputs,
    };
  },
  [actions.runCheckFailure]: (state) => {
    const newState = { ...state, processing: false };
    return newState;
  },
}, { processing: false, outputs: [] });

export default combineReducers({
  code,
  currentTabInfo,
  notification,
  checkInfo,
});
