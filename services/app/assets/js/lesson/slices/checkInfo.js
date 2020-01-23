// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';

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

export const { actions } = slice;
export default slice.reducer;
