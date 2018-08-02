import '@babel/polyfill';
import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { I18nextProvider } from 'react-i18next';
import i18n from '../lib/i18n';

import configureStore from '../lib/configureStore';
import App from './components/App';
import reducers from './reducers';
import EntityContext from './EntityContext';

import * as actions from './actions';

const currentUser = gon.getAsset('current_user');
const lesson = gon.getAsset('lesson');
const language = gon.getAsset('language');
const description = gon.getAsset('lesson_description');
const userFinishedLesson = gon.getAsset('user_finished_lesson');
const prevLesson = gon.getAsset('prev_lesson');

const run = () => {
  const store = configureStore(reducers, {
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
    lesson: { ...lesson, ...description },
  };

  ReactDOM.render(
    <Provider store={store}>
      <I18nextProvider i18n={i18n}>
        <EntityContext.Provider value={entities}>
          <App
            userFinishedLesson={userFinishedLesson}
          />
        </EntityContext.Provider>
      </I18nextProvider>
    </Provider>,
    document.getElementById('basics-lesson-container'),
  );
};

if (!currentUser.guest) {
  run();
}
