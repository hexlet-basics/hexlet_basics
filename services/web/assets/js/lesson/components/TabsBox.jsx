// @ts-check

import React, { useContext } from 'react';
import { useTranslation } from 'react-i18next';
import { useSelector } from 'react-redux';
import cn from 'classnames';
import { Tab, Nav } from 'react-bootstrap';
import Editor from './Editor';
import Console from './Console';
import Solution from './Solution';
import connect from '../connect';
import EntityContext from '../EntityContext';

/**
 * @param {Object} props
 */
const TabsBox = (props) => {
  const {
    changeCode,
    userFinishedLesson,
    startTime,
    selectTab,
  } = props;

  const { t } = useTranslation();
  const { lesson, language } = useContext(EntityContext);
  const { currentTabInfo, checkInfo } = useSelector((state) => state);

  const badgeClassName = cn('badge badge-outline mb-2 mb-sm-0 p-2', {
    'bg-green-lt': checkInfo.passed,
    'bg-red-lt': !checkInfo.passed,
  });
  const headline = checkInfo.result ? t(`check.${checkInfo.result}.headline`) : null;

  return (
    <Tab.Container id="tabs" activeKey={currentTabInfo.title} onSelect={selectTab}>
      <div className="d-flex flex-column flex-sm-row-reverse flex-shrink-0">
        <div className="my-auto d-none d-sm-block">
          {headline && <span className={badgeClassName}>{headline}</span>}
        </div>
        <div className="mr-auto flex-shrink-0">
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
        </div>
      </div>
      <Tab.Content bsPrefix="d-flex h-100 tab-content overflow-auto">
        <Tab.Pane eventKey="editor" bsPrefix="tab-pane h-100 w-100 overflow-hidden">
          <Editor
            defaultValue={lesson.prepared_code}
            onCodeChange={changeCode}
            language={language.slug}
            current={currentTabInfo.title === 'editor'}
          />
        </Tab.Pane>
        <Tab.Pane eventKey="console" bsPrefix="tab-pane h-100 w-100">
          <Console checkInfo={checkInfo} />
        </Tab.Pane>
        <Tab.Pane eventKey="solution" bsPrefix="tab-pane h-100 w-100">
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

export default connect()(TabsBox);
