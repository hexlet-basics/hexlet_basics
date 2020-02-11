// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';

import { persistChangeCodeReducer } from '../../lib/persistReducer';

const slice = createSlice({
  name: 'editor',
  initialState: { content: '' },
  reducers: {
    changeCode(state, { payload }) {
      const { content } = payload;
      state.content = content;
    },
  },
});

export const { actions } = slice;
export default persistChangeCodeReducer(slice.reducer);
