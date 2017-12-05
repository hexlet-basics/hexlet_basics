import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';

import configureStore from '../lib/configureStore';
import AppContainer from './containers/App';
import reducers from './reducers';

const lesson = gon.getAsset('lesson');
const language = gon.getAsset('language');
const description = gon.getAsset('lesson_description');

const store = configureStore(reducers);

ReactDOM.render(
  <Provider store={store}>
    <AppContainer lesson={{ ...lesson, ...description }} language={language} />
  </Provider>,
  document.getElementById('basics-lesson-container'),
);
