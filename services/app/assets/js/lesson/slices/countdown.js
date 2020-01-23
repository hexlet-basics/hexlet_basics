// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';
import { addMinutes } from 'date-fns';

const slice = createSlice({
  name: 'countdown',
  initialState: {
    currentTime: null,
    startTime: null,
    finishTime: null,
  },
  reducers: {
    init(state, { payload }) {
      const { startTime } = payload;
      state.startTime = startTime;
      state.finishTime = addMinutes(startTime, 30);
    },
    updateCountdown(state, { payload }) {
      const { currentTime } = payload;
      state.currentTime = currentTime;
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
