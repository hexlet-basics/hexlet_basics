// @ts-check

import 'core-js/stable';
import 'regenerator-runtime/runtime';
import hljs from 'highlight.js';
import run from './init';
import '../../css/app.scss';
import '../shared';
import '../lib/i18n';

const currentUser = gon.getAsset('current_user');
hljs.initHighlightingOnLoad();
if (!currentUser.guest) {
  run();
}
