// @ts-check

import 'react-toastify/dist/ReactToastify.css';

import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { configureStore, getDefaultMiddleware } from '@reduxjs/toolkit';
import { toast } from 'react-toastify';
import { persistStore } from 'redux-persist';
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
  const middleware = getDefaultMiddleware({
    serializableCheck: false,
  });

  const store = configureStore({
    reducer,
    // code: lesson.prepared_code,
    middleware,
  });

  const persistor = persistStore(store);

  store.dispatch(actions.initLessonState({
    userFinishedLesson,
  }));

  const entities = {
    prevLesson,
    language,
    lesson,
    lessonDescription,
    persistor,
  };

  ReactDOM.render(
    <Provider store={store}>
      <EntityContext.Provider value={entities}>
        <App
          userFinishedLesson={userFinishedLesson}
          language={language}
          startTime={Date.now()}
        />
      </EntityContext.Provider>
    </Provider>,
    document.getElementById('basics-lesson-container'),
  );
  toast.configure();
};
