// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';

const slice = createSlice({
  name: 'solution',
  initialState: { canBeShown: false, shown: false },
  reducers: {
    init: (state, { payload }) => {
      const { userFinishedLesson } = payload;
      const lessonFinished = !!userFinishedLesson;
      state.canBeShown = lessonFinished;
      state.shown = lessonFinished;
    },
    showSolution: (state) => {
      state.shown = true;
    },
    makeSolutionAvailable: (state) => {
      state.canBeShown = true;
    },
    runCheckSuccess: (state, { payload }) => {
      const { check: { data: { attributes } } } = payload;
      if (attributes.passed) {
        state.canBeShown = true;
        state.shown = true;
      }
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
