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

// export const runCheckRequest = createAction('CHECK/RUN/REQUEST');
// export const runCheckSuccess = createAction('CHECK/RUN/SUCCESS');
// export const runCheckFailure = createAction('CHECK/RUN/FAILURE');

// export const changeCode = createAction('CODE/CHANGE');
// export const selectTab = createAction('TAB/SELECT');

// // export const dismissNotification = createAction('NOTIFICATION/DISMISS');

// export const runCheck = ({ lesson, code }) => async (dispatch) => {
//   dispatch(runCheckRequest());
//   const url = `/api/lessons/${lesson.id}/checks`; // TOOO: jsroutes
//   const data = {
//     type: 'check',
//     attributes: {
//       code,
//     },
//   };
//   try {
//     const response = await axios.post(url, { data });
//     dispatch(runCheckSuccess({ check: response.data }));
//   } catch (e) {
//     console.log(e);
//     dispatch(runCheckFailure({ code: e.response.status }));
//   }
// };

// export const updateCountdown = createAction('COUNTDOWN/UPDATE', () => ({ currentTime: Date.now() }));

// const checkingInterval = 1000;

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
