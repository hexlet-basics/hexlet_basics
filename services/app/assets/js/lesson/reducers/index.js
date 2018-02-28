import { combineReducers } from 'redux';
import { handleActions } from 'redux-actions';

import * as actions from '../actions';

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

const canRenderSolution = handleActions({
  [actions.toggleSolution]: () => true,
}, false);

const currentTabInfo = handleActions({
  [actions.runCheckRequest]: (state) => {
    const newState = { ...state, current: 'console' };
    return newState;
  },
  [actions.selectTab]: (state, { payload }) => {
    const { current } = payload;
    const newClicksCount = state.current === current ? state.clicksCount + 1 : 0;
    return { current, clicksCount: newClicksCount };
  },
}, { current: 'editor', clicksCount: 0 });

const notification = handleActions({
  [actions.dismissNotification]: () => {
    const info = null;
    return info;
  },
  [actions.runCheckFailure]: () => {
    const msg = { type: 'danger', headline: 'alert.error.headline', message: 'alert.error.message' };
    return msg;
  },
  [actions.runCheckRequest]: () => {
    const info = null;
    return info;
  },
  [actions.runCheckSuccess]: (_, { payload }) => {
    const { check: { data: { attributes } } } = payload;
    if (attributes.status === 0) {
      return { type: 'success', headline: 'alert.passed.headline', message: 'alert.passed.message' };
    }

    return { type: 'warning', headline: 'alert.failed.headline', message: 'alert.failed.message' };
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
  canRenderSolution,
});
