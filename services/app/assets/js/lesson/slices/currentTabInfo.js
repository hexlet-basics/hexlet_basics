// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';

const slice = createSlice({
  name: 'currentTabInfo',
  initialState: { current: 'editor', clicksCount: 0 },
  reducers: {
    runCheckRequest(state) {
      state.current = 'console';
    },
    selectTab(state, { payload }) {
      const { current } = payload;
      state.clicksCount = state.current === current ? state.clicksCount + 1 : 0;
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
