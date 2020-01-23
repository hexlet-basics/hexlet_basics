// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';
import i18next from 'i18next';
import { toast  } from 'react-toastify';
import axios from 'axios';

const slice = createSlice({
  name: 'checkInfo',
  initialState: { processing: false, output: '' },
  reducers: {
    runCheckRequest(state) {
      state.output = '';
      state.processing = true;
    },
    runCheckSuccess(state, { payload }) {
      const { check: { data: { attributes } } } = payload;
      state.processing = false;
      state.output = atob(attributes.output);
    },
    runCheckFailure(state) {
      state.processing = false;
    },
  },
});

const { runCheckRequest, runCheckSuccess, runCheckFailure } = slice.actions;

const runCheck = ({ lesson, code }) => async (dispatch) => {
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
    dispatch(runCheckFailure({ code: e.response.status }));
    const key = e.response ? 'server' : 'network';
    toast(i18next.t(`errors.${key}`));
    throw e;
  }
};

const actions = { ...slice.actions, runCheck };
export { actions };
export default slice.reducer;
