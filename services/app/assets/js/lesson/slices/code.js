// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';

const slice = createSlice({
  name: 'code',
  initialState: { content: '' },
  reducers: {
    changeCode(state, { payload }) {
      const { content } = payload;
      state.content = content;
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
