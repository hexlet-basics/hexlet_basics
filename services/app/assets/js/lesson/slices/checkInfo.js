// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';
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
    console.log(e);
    dispatch(runCheckFailure({ code: e.response.status }));
  }
};

const actions = { ...slice.actions, runCheck };
export const { actions };
export default slice.reducer;
