// @ts-check

import React, { useContext } from 'react';
import { useSelector } from 'react-redux';
import { PersistGate } from 'redux-persist/integration/react';
import TabsBox from './TabsBox';
import HTMLPreview from './HTMLPreview';
import ControlBox from './ControlBox';
import EntityContext from '../EntityContext';

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

  const { persistor } = useContext(EntityContext);

  const currentViewOptions = getViewOptions(language.name);

  return (
    <>
      <PersistGate loading={null} persistor={persistor}>
        <TabsBox
          startTime={startTime}
          className={currentViewOptions.tabsBoxClassName}
          active={currentTabInfo.current}
          userFinishedLesson={userFinishedLesson}
        />
        {currentTabInfo.title === 'editor' && currentViewOptions.component}
        <ControlBox userFinishedLesson={userFinishedLesson} />
      </PersistGate>
    </>
  );
};

export default App;
