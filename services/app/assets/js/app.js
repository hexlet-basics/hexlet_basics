// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// import 'jquery';
import hljs from 'highlight.js';
// import '@fortawesome/react-fontawesome';
import fontawesome from '@fortawesome/fontawesome';
import brands from '@fortawesome/fontawesome-free-brands';
import solid from '@fortawesome/fontawesome-free-solid';
import 'bootstrap';
// import 'jquery-ujs';
// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import '../../deps/phoenix_html/priv/static/phoenix_html';

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
// import '../css/app.scss';
// import '../css/lesson.scss';

// import '@babel/polyfill';
// import 'react';
// import 'react-dom';
// import 'react-redux';
// import 'redux';
// import 'redux-actions';
// import 'prop-types';
// import 'classnames';
// import 'react-monaco-editor';
// import 'react-tabs';
// import 'react-bs-notifier';
// import 'axios';
// import 'ansi_up';
// import 'redux-thunk';
// import 'react-i18next';
// import 'markdown-it';
// import 'tether';
// import 'popper.js';
// import 'bootstrap';

fontawesome.library.add(brands);
fontawesome.library.add(solid);

hljs.initHighlightingOnLoad();
