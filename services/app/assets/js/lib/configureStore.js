import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
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
  /* eslint-enable */
  return store;
}
