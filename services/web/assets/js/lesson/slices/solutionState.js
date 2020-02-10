// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';
import { actions as checkInfoActions } from './checkInfo';
import { actions as lessonStateActions } from './lessonState';

const slice = createSlice({
  name: 'solution',
  initialState: { canBeShown: false, shown: false },
  reducers: {
    showSolution: (state) => {
      state.shown = true;
    },
    makeSolutionAvailable: (state) => {
      state.canBeShown = true;
    },
  },
  extraReducers: {
    [checkInfoActions.runCheckSuccess]: (state, { payload }) => {
      const { check: { data: { attributes } } } = payload;
      if (attributes.passed) {
        state.canBeShown = true;
        state.shown = true;
      }
    },
    [lessonStateActions.initLessonState]: (state, { payload }) => {
      const { userFinishedLesson } = payload;
      const lessonFinished = !!userFinishedLesson;
      state.canBeShown = lessonFinished;
      state.shown = lessonFinished;
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
