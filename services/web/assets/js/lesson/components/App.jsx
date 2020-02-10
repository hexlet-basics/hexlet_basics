// @ts-check

import React from 'react';
import { useSelector } from 'react-redux';
import TabsBox from './TabsBox';
import HTMLPreview from './HTMLPreview';
import ControlBox from './ControlBox';

const getViewOptions = (languageName) => {
  const { editor } = useSelector((state) => state);

  switch (languageName) {
    case 'css':
    case 'html':
      return {
        tabsBoxClassName: 'h-50',
        component: <HTMLPreview html={editor.content} />,
      };
    default:
      return {
        tabsBoxClassName: 'h-100',
        component: null,
      };
  }
};

const App = (props) => {
  const {
    startTime,
    language,
    userFinishedLesson,
  } = props;

  const { currentTabInfo } = useSelector((state) => state);

  const currentViewOptions = getViewOptions(language.name);

  return (
    <>
      <TabsBox
        startTime={startTime}
        className={currentViewOptions.tabsBoxClassName}
        active={currentTabInfo.current}
        userFinishedLesson={userFinishedLesson}
      />
      {currentTabInfo.title === 'editor' && currentViewOptions.component}
      <ControlBox userFinishedLesson={userFinishedLesson} />
    </>
  );
};

export default App;
