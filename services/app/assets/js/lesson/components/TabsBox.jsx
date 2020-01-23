// @ts-check

import React from 'react';
import { withTranslation } from 'react-i18next';
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

@connect(mapStateToProps)
@withTranslation()
class TabsBox extends React.Component {
  static contextType = EntityContext;

  render() {
    const {
      // className,
      checkInfo,
      currentTabInfo,
      // notification,
      changeCode,
      userFinishedLesson,
      startTime,
      t,
    } = this.props;

    const {
      lesson,
      language,
    } = this.context;

    return (
      <Tabs id="workspace-tabs" defaultActiveKey="editor">
        <Tab eventKey="editor" title={t('editor')}>
          <Editor
            defaultValue={lesson.prepared_code}
            onCodeChange={changeCode}
            language={language.slug}
            current={currentTabInfo.current === 'editor'}
            clicksCount={currentTabInfo.clicksCount}
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
  }
}

export default TabsBox;
