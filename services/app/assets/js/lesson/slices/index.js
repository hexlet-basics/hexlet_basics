// @ts-check

import { combineReducers } from 'redux';
import { addMinutes } from 'date-fns';

const code = handleActions({
  [actions.changeCode]: (_state, { payload }) => {
    const { content } = payload;
    return content;
  },
}, null);

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

// const notification = handleActions({
//   // [actions.dismissNotification]: () => {
//   //   const info = null;
//   //   return info;
//   // },
//   [actions.runCheckFailure]: (_state, { payload }) => {
//     let message;
//     switch (payload.code) {
//       case 403:
//         message = 'alert.error.forbidden';
//         break;
//       default:
//         message = 'alert.error.message';
//         break;
//     }
//     const msg = { type: 'danger', headline: 'alert.error.headline', message };
//     return msg;
//   },
//   [actions.runCheckRequest]: () => {
//     const info = null;
//     return info;
//   },
//   [actions.runCheckSuccess]: (_, { payload }) => {
//     const { check: { data: { attributes } } } = payload;
//     if (attributes.passed) {
//       return { type: 'success', headline: 'alert.passed.headline', message: 'alert.passed.message' };
//     }

//     return {
//       type: 'warning',
//       headline: `alert.${attributes.result}.headline`,
//       message: `alert.${attributes.result}.message`,
//     };
//   },
// }, null);

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
      output: atob(attributes.output),
    };
  },
  [actions.runCheckFailure]: (state) => {
    const newState = { ...state, processing: false };
    return newState;
  },
}, { processing: false, output: '' });

const countdown = handleActions({
  [actions.init]: (state, { payload }) => {
    const { startTime } = payload;
    const finishTime = addMinutes(startTime, 30);
    // const finishTime = dateFns.addSeconds(startTime, 10);
    return { ...state, startTime, finishTime };
  },
  [actions.updateCountdown]: (state, { payload }) => {
    const { currentTime } = payload;
    return { ...state, currentTime };
  },
}, {
  currentTime: null,
  startTime: null,
  finishTime: null,
});

const lessonState = handleActions({
  [actions.init]: (_state, { payload }) => {
    const { userFinishedLesson } = payload;
    return { finished: !!userFinishedLesson };
  },
  [actions.runCheckSuccess]: (state, { payload }) => {
    if (state.finished) {
      return state;
    }
    const { check: { data: { attributes } } } = payload;
    const newState = { ...state, finished: attributes.passed };
    return newState;
  },
}, {
  finished: null,
});

const solutionState = handleActions({
  [actions.init]: (_state, { payload }) => {
    const { userFinishedLesson } = payload;
    const lessonFinished = !!userFinishedLesson;
    return { canBeShown: lessonFinished, shown: lessonFinished };
  },
  [actions.showSolution]: (state) => {
    const newState = { ...state, shown: true };
    return newState;
  },
  [actions.makeSolutionAvailable]: (state) => {
    const newState = { ...state, canBeShown: true };
    return newState;
  },
  [actions.runCheckSuccess]: (state, { payload }) => {
    const { check: { data: { attributes } } } = payload;
    const newState = attributes.passed ? { canBeShown: true, shown: true } : { ...state };
    return newState;
  },
}, { canBeShown: false, shown: false });

export default combineReducers({
  code,
  currentTabInfo,
  notification,
  checkInfo,
  countdown,
  lessonState,
  solutionState,
});

// import Routes from 'routes';
import axios from 'axios';

export const init = createAction('INIT');
export const makeSolutionAvailable = createAction('SOLUTION/MAKE/AVAILABLE');

export const runCheckRequest = createAction('CHECK/RUN/REQUEST');
export const runCheckSuccess = createAction('CHECK/RUN/SUCCESS');
export const runCheckFailure = createAction('CHECK/RUN/FAILURE');

export const changeCode = createAction('CODE/CHANGE');
export const selectTab = createAction('TAB/SELECT');

// export const dismissNotification = createAction('NOTIFICATION/DISMISS');

export const runCheck = ({ lesson, code }) => async (dispatch) => {
  dispatch(runCheckRequest());
  const url = `/api/lessons/${lesson.id}/checks`; // TOOO: jsroutes
  const data = {
    type: 'check',
    attributes: {
      code,
    },
  };
  try {
    const response = await axios.post(url, { data });
    dispatch(runCheckSuccess({ check: response.data }));
  } catch (e) {
    console.log(e);
    dispatch(runCheckFailure({ code: e.response.status }));
  }
};

export const updateCountdown = createAction('COUNTDOWN/UPDATE', () => ({ currentTime: Date.now() }));

const checkingInterval = 1000;

export const updateCountdownTimer = (store) => {
  const { countdown: { currentTime, finishTime } } = store.getState();
  if (currentTime >= finishTime) {
    store.dispatch(makeSolutionAvailable());
    return;
  }
  store.dispatch(updateCountdown());
  setTimeout(() => updateCountdownTimer(store), checkingInterval);
};

export const showSolution = createAction('SOLUTION/SHOW');
