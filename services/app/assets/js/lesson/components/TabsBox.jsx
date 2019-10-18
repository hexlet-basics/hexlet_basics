// @ts-check

import React from 'react';
import { withTranslation } from 'react-i18next';
import cn from 'classnames';
import {
  TabContent, TabPane, Nav, NavItem, NavLink,
} from 'reactstrap';
import Editor from './Editor';
import Console from './Console';
import Solution from './Solution';
import withActive from '../hoc/withActive';
import connect from '../connect';
import EntityContext from '../EntityContext';

const mapStateToProps = (state) => {
  const { code, notification, checkInfo, currentTabInfo } = state;
  const props = { code: code.content, checkInfo, currentTabInfo, notification };
  return props;
};

const getEditorValue = (content) => content ? Object.values(content).join('') : '';

@connect(mapStateToProps)
@withActive()
@withTranslation()
class TabsBox extends React.Component {
  static contextType = EntityContext;

  render() {
    const {
      className,
      code,
      checkInfo,
      currentTabInfo,
      setActive,
      notification,
      changeCode,
      userFinishedLesson,
      active,
      activeClass,
      t,
    } = this.props;

    const {
      lesson,
      language,
    } = this.context;

    const activateNavLink = activeClass('active bg-black');
    const activateTabPane = activeClass('d-flex flex-column overflow-auto h-100 w-100');

    const tabNames = ['editor', 'console', 'solution'];

    const badgeClassName = cn('badge mb-2 mb-sm-0 p-2', {
      [`badge-${notification && notification.type}`]: true,
    });

    const elements = tabNames.map((name) => {
      const className = `text-light ${activateNavLink(name)}`;
      return (
        <NavItem key={name} className="flex-fill">
          <NavLink href="#" onClick={setActive(name)} className={className}>
            {t(name)}
          </NavLink>
        </NavItem>
      );
    });

    const defaultValue = getEditorValue(code);

    return (
      <React.Fragment>
        <div className="d-flex flex-column flex-sm-row-reverse">
          <div className="my-auto">
            <span className={badgeClassName}>{notification && t(notification.headline)}</span>
          </div>
          <div className="mr-auto">
            <Nav tabs className="flex-nowrap">{elements}</Nav>
          </div>
        </div>
        <TabContent className={`d-flex ${className}`} activeTab={active}>
          <TabPane tabId="editor" className={activateTabPane('editor')}>
            <Editor
              defaultValue={defaultValue}
              onCodeChange={changeCode}
              language={language.slug}
              current={currentTabInfo.current === 'editor'}
              clicksCount={currentTabInfo.clicksCount}
            />
          </TabPane>
          <TabPane tabId="console" className={activateTabPane('console')}>
            <Console output={checkInfo.output} />
          </TabPane>
          <TabPane tabId="solution" className={activateTabPane('solution')}>
            <Solution
              defaultValue={lesson.original_code}
              language={language.slug}
              userFinishedLesson={userFinishedLesson}
            />
          </TabPane>
        </TabContent>
      </React.Fragment>
    );
  }
}

export default TabsBox;
