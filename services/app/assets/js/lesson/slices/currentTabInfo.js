// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';
import { actions as checkInfoActions } from './checkInfo';

const slice = createSlice({
  name: 'currentTabInfo',
  initialState: { title: 'editor', clicksCount: 0 },
  reducers: {
    selectTab(state, { payload }) {
      state.clicksCount = state.title === payload ? state.clicksCount + 1 : 0;
      state.title = payload;
    },
  },
  extraReducers: {
    [checkInfoActions.runCheckRequest](state) {
      state.title = 'console';
      state.clicksCount = 0;
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
