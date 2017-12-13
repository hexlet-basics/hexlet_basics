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

const finished = handleActions({
  [actions.runCheckSuccess]: (state, { payload }) => {
    const { check: { data: { attributes } } } = payload;
    return attributes.status === 0;
  },
}, false);

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
    const msg = { type: 'danger', headline: 'Oops!', message: 'something was wrong, try one more time' };
    return msg;
  },
  [actions.runCheckRequest]: () => {
    const info = null;
    return info;
  },
  [actions.runCheckSuccess]: (_, { payload }) => {
    const { check: { data: { attributes } } } = payload;
    if (attributes.status === 0) {
      return { type: 'success', headline: 'Tests passed', message: 'Whoa! You did it! Go next.' };
    }

    return { type: 'warning', headline: 'Tests Failed', message: 'Fix errros and run again' };
  },
}, null);

const checkInfo = handleActions({
  [actions.runCheckRequest]: (state) => {
    const newState = { ...state, output: '', processing: true };
    return newState;
  },
  [actions.runCheckSuccess]: (state, { payload }) => {
    const { check: { data: { attributes } } } = payload;
    return {
      ...state,
      processing: false,
      output: attributes.output,
    };
  },
  [actions.runCheckFailure]: (state) => {
    const newState = { ...state, processing: false };
    return newState;
  },
}, { processing: false, output: '' });

export default combineReducers({
  finished,
  code,
  currentTabInfo,
  notification,
  checkInfo,
});
