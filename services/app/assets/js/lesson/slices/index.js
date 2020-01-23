// @ts-check

import { combineReducers } from 'redux';

import checkInfo, { actions as checkInfoActions } from './checkInfo';
import countdown, { actions as countdownActions } from './countdown';
import currentTabInfo, { actions as currentTabInfoActions } from './currentTabInfo';
import lessonState, { actions as lessonActions } from './lessonState';
import notifications, { actions as notificationsActions } from './notifications';
import solutionState, { actions as solutionActions } from './solutionState';
import code, { actions as codeActions } from './code';

export default combineReducers({
  code,
  checkInfo,
  countdown,
  currentTabInfo,
  lessonState,
  notifications,
  solutionState,
});

const actions = {
  ...codeActions,
  ...checkInfoActions,
  ...countdownActions,
  ...lessonActions,
  ...notificationsActions,
  ...solutionActions,
  ...currentTabInfoActions,
};

export {
  actions,
};

// import Routes from 'routes';
// import axios from 'axios';

// export const init = createAction('INIT');
// export const makeSolutionAvailable = createAction('SOLUTION/MAKE/AVAILABLE');

// export const changeCode = createAction('CODE/CHANGE');
// export const selectTab = createAction('TAB/SELECT');

// // export const dismissNotification = createAction('NOTIFICATION/DISMISS');

// export const updateCountdownTimer = (store) => {
//   const { countdown: { currentTime, finishTime } } = store.getState();
//   if (currentTime >= finishTime) {
//     store.dispatch(makeSolutionAvailable());
//     return;
//   }
//   store.dispatch(updateCountdown());
//   setTimeout(() => updateCountdownTimer(store), checkingInterval);
// };

// export const showSolution = createAction('SOLUTION/SHOW');
