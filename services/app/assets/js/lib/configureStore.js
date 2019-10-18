// @ts-check

import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import { persistStore } from 'redux-persist';
// import promise from 'redux-promise';

const middlewares = [
  thunk,
  // promise,
];

export default function configureStore(reducer, initialState) {
  /* eslint-disable no-underscore-dangle */
  const store = createStore(reducer, initialState, compose(
    applyMiddleware(...middlewares),
    window.__REDUX_DEVTOOLS_EXTENSION__ ? window.__REDUX_DEVTOOLS_EXTENSION__() : f => f,
  ));

  const persistor = persistStore(store)
  /* eslint-enable */
  return { store, persistor };
}
