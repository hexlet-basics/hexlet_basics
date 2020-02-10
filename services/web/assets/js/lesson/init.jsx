// @ts-check

import 'react-toastify/dist/ReactToastify.css';

import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { configureStore } from '@reduxjs/toolkit';
import { toast } from 'react-toastify';
import reducer, { actions } from './slices';

// import configureStore from '../lib/configureStore';
import App from './components/App';
import EntityContext from './EntityContext';

import { PersistGate } from 'redux-persist/integration/react';

const lesson = gon.getAsset('lesson');
const language = gon.getAsset('language');
const lessonDescription = gon.getAsset('lesson_description');
const userFinishedLesson = gon.getAsset('user_finished_lesson');
const prevLesson = gon.getAsset('prev_lesson');

export default () => {
  const { store, persistor } = configureStore({
    reducer,
    // code: lesson.prepared_code,
  });

  store.dispatch(actions.initLessonState({
    userFinishedLesson,
  }));

  const entities = {
    prevLesson,
    language,
    lesson,
    lessonDescription,
  };

  ReactDOM.render(
    <Provider store={store}>
      <PersistGate loading={null} persistor={persistor}>
        <EntityContext.Provider value={entities}>
          <App
            userFinishedLesson={userFinishedLesson}
            language={language}
            startTime={Date.now()}
          />
        </EntityContext.Provider>
      </PersistGate>
    </Provider>,
    document.getElementById('basics-lesson-container'),
  );
  toast.configure();
};
