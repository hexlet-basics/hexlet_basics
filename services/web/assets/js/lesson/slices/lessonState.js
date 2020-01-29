// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';
import { actions as checkInfoActions } from './checkInfo';

const slice = createSlice({
  name: 'lesson',
  initialState: { finished: null },
  reducers: {
    initLessonState: (state, { payload }) => {
      const { userFinishedLesson } = payload;
      state.finished = !!userFinishedLesson;
    },
  },
  extraReducers: {
    [checkInfoActions.runCheckSuccess]: (state, { payload }) => {
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
