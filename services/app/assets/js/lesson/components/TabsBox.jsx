// @ts-check

import React, { useState, useContext } from 'react';
import { useTranslation } from 'react-i18next';
// import cn from 'classnames';
import {
  Tabs, Tab, Nav,
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
    <Tab.Container id="tabs" activeKey={currentTabInfo.title} onSelect={selectTab}>
      <Nav variant="tabs">
        <Nav.Item>
          <Nav.Link eventKey="editor" title={t('editor')}>{t('editor')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
          <Nav.Link eventKey="console" title={t('console')}>{t('console')}</Nav.Link>
        </Nav.Item>
        <Nav.Item>
          <Nav.Link eventKey="solution" title={t('solution')}>{t('solution')}</Nav.Link>
        </Nav.Item>
      </Nav>
      <Tab.Content bsPrefix="h-100 tab-content">
        <Tab.Pane eventKey="editor" bsPrefix="tab-pane h-100">
          <Editor
            defaultValue={lesson.prepared_code}
            onCodeChange={changeCode}
            language={language.slug}
            current={currentTabInfo.title === 'editor'}
          />
        </Tab.Pane>
        <Tab.Pane eventKey="console" bsPrefix="tab-pane h-100">
          <Console output={checkInfo.output} />
        </Tab.Pane>
        <Tab.Pane eventKey="solution" bsPrefix="tab-pane h-100">
          <Solution
            startTime={startTime}
            defaultValue={lesson.original_code}
            language={language.slug}
            userFinishedLesson={userFinishedLesson}
          />
        </Tab.Pane>
      </Tab.Content>
    </Tab.Container>
  );
};

export default connect(mapStateToProps)(TabsBox);
