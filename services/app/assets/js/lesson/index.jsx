// @ts-check

import '@babel/polyfill';
import hljs from 'highlight.js';

import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';

import '../../css/app.scss';

import '../shared';
import '../lib/i18n';

import configureStore from '../lib/configureStore';
import App from './components/App';
import reducers from './reducers';
import EntityContext from './EntityContext';

import * as actions from './actions';
import {PersistGate} from 'redux-persist/integration/react';

const currentUser = gon.getAsset('current_user');
const lesson = gon.getAsset('lesson');
const language = gon.getAsset('language');
const lessonDescription = gon.getAsset('lesson_description');
const userFinishedLesson = gon.getAsset('user_finished_lesson');
const prevLesson = gon.getAsset('prev_lesson');

const run = () => {
  const { store, persistor } = configureStore(reducers, {
    code: lesson.prepared_code,
  });


  store.dispatch(actions.init({
    startTime: Date.now(),
    userFinishedLesson,
  }));
  actions.updateCountdownTimer(store);


  const entities = {
    prevLesson,
    language,
    lesson,
    lessonDescription
  };

  ReactDOM.render(
    <Provider store={store}>
      <EntityContext.Provider value={entities}>
        <PersistGate loading={null} persistor={persistor}>
          <App
            userFinishedLesson={userFinishedLesson}
            language={language}
          />
        </PersistGate>
      </EntityContext.Provider>
    </Provider>,
    document.getElementById('basics-lesson-container'),
  );
};

hljs.initHighlightingOnLoad();
if (!currentUser.guest) {
  run();
}
