import { createAction } from 'redux-actions';
// import Routes from 'routes';
import axios from 'axios';

export const runCheckRequest = createAction('CHECK_RUN_REQUEST');
export const runCheckSuccess = createAction('CHECK_RUN_SUCCESS');
export const runCheckFailure = createAction('CHECK_RUN_FAILURE');

export const changeCode = createAction('CODE_CHANGE');
export const selectTab = createAction('TAB_SELECT');

export const dismissNotification = createAction('NOTIFICATION_DISMISS');

export const runCheck = ({ code }) => async (dispatch) => {
  // const { code } = data;
  dispatch(runCheckRequest());
  const url = '/api/checks'; // TOOO: jsroutes
  const data = {
    type: 'check',
    attributes: {
      code,
    },
  };
  try {
    const response = await axios.post(url, data);
    dispatch(runCheckSuccess({ responseObject: response.data }));
  } catch (e) {
    console.log(e);
    dispatch(runCheckFailure());
  }
};
