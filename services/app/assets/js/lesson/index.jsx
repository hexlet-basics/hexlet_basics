import gon from 'gon';
import React from 'react';
import ReactDOM from 'react-dom';

import App from './components/App.jsx';

const lesson = gon.getAsset('lesson');
const language = gon.getAsset('language');
const description = gon.getAsset('lesson_description');

ReactDOM.render(
  <App lesson={{ ...lesson, ...description }} language={language} />,
  document.getElementById('basics-lesson-container'),
);
