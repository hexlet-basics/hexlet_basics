// @ts-check

import React, { useState, useContext } from 'react';
import { useTranslation } from 'react-i18next';
// import cn from 'classnames';
import {
  Tabs, Tab,
} from 'react-bootstrap';
import Editor from './Editor';
import Console from './Console';
import Solution from './Solution';
import connect from '../connect';
import EntityContext from '../EntityContext';

const mapStateToProps = (state) => {
  const { notification, checkInfo, currentTabInfo } = state;
  const props = { checkInfo, currentTabInfo, notification };
  return props;
};

// @connect(mapStateToProps)
// @withTranslation()
// class TabsBox extends React.Component {
//   static contextType = EntityContext;

const TabsBox = (props) => {
  const {
    // className,
    checkInfo,
    currentTabInfo,
    // notification,
    changeCode,
    userFinishedLesson,
    startTime,
    selectTab,
  } = props;

  const { t } = useTranslation();
  const { lesson, language } = useContext(EntityContext);

  return (
    <Tabs id="tabs" activeKey={currentTabInfo.title} onSelect={selectTab}>
      <Tab eventKey="editor" title={t('editor')}>
        <Editor
          defaultValue={lesson.prepared_code}
          onCodeChange={changeCode}
          language={language.slug}
          current={currentTabInfo.title === 'editor'}
        />
      </Tab>
      <Tab eventKey="console" title={t('console')}>
        <Console output={checkInfo.output} />
      </Tab>
      <Tab eventKey="solution" title={t('solution')}>
        <Solution
          startTime={startTime}
          defaultValue={lesson.original_code}
          language={language.slug}
          userFinishedLesson={userFinishedLesson}
        />
      </Tab>
    </Tabs>
  );
};

export default connect(mapStateToProps)(TabsBox);
