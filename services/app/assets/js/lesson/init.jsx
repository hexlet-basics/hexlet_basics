// @ts-check

import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { configureStore } from '@reduxjs/toolkit';
import reducer, { actions } from './slices';

// import configureStore from '../lib/configureStore';
import App from './components/App';
import EntityContext from './EntityContext';

const lesson = gon.getAsset('lesson');
const language = gon.getAsset('language');
const lessonDescription = gon.getAsset('lesson_description');
const userFinishedLesson = gon.getAsset('user_finished_lesson');
const prevLesson = gon.getAsset('prev_lesson');

export default () => {
  const store = configureStore({
    reducer,
    // code: lesson.prepared_code,
  });


  // store.dispatch(actions.init({
  //   startTime: Date.now(),
  //   userFinishedLesson,
  // }));
  // actions.updateCountdownTimer(store);


  const entities = {
    prevLesson,
    language,
    lesson,
    lessonDescription
  };

  ReactDOM.render(
    <Provider store={store}>
      <EntityContext.Provider value={entities}>
        <App
          userFinishedLesson={userFinishedLesson}
          language={language}
        />
      </EntityContext.Provider>
    </Provider>,
    document.getElementById('basics-lesson-container'),
  );
};
