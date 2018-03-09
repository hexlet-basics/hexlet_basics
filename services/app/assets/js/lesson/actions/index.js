import { createAction } from 'redux-actions';
// import Routes from 'routes';
import axios from 'axios';

export const runCheckRequest = createAction('CHECK_RUN_REQUEST');
export const runCheckSuccess = createAction('CHECK_RUN_SUCCESS');
export const runCheckFailure = createAction('CHECK_RUN_FAILURE');

export const changeCode = createAction('CODE_CHANGE');
export const selectTab = createAction('TAB_SELECT');

export const dismissNotification = createAction('NOTIFICATION_DISMISS');

export const timePassed = createAction('CHECK_TIMER');

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
    dispatch(runCheckFailure());
  }
};

export const startTimer = time => dispatch =>
  setTimeout(() => dispatch(timePassed()), time);
