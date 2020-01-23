// @ts-check
/* eslint-disable no-param-reassign */

import { createSlice } from '@reduxjs/toolkit';

const slice = createSlice({
  name: 'notifications',
  initialState: { alert: null },
  reducers: {
    dismissNotification(state) {
      state.alert = null;
    },
    runCheckRequest(state) {
      state.alert = null;
    },
    runCheckFailure(state, { payload }) {
      let message;
      switch (payload.code) {
        case 403:
          message = 'alert.error.forbidden';
          break;
        default:
          message = 'alert.error.message';
          break;
      }
      state.alert = { type: 'danger', headline: 'alert.error.headline', message };
    },
    runCheckSuccess(state, { payload }) {
      const { check: { data: { attributes } } } = payload;
      if (attributes.passed) {
        state.alert = {
          type: 'success',
          headline: 'alert.passed.headline',
          message: 'alert.passed.message',
        };
      }

      state.alert = {
        type: 'warning',
        headline: `alert.${attributes.result}.headline`,
        message: `alert.${attributes.result}.message`,
      };
    },
  },
});

export const { actions } = slice;
export default slice.reducer;
