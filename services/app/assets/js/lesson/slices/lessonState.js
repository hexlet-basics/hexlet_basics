// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';

const slice = createSlice({
  name: 'lesson',
  initialState: { finished: null },
  reducers: {
    init: (state, { payload }) => {
      const { userFinishedLesson } = payload;
      state.finished = !!userFinishedLesson;
    },
    runCheckSuccess: (state, { payload }) => {
      if (state.finished) {
        return;
      }
      const { check: { data: { attributes } } } = payload;
      state.finished = attributes.passed;
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
