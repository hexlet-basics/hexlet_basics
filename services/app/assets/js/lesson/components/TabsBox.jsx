import React from 'react';
import PropTypes from 'prop-types';
import { TabContent, TabPane, Nav, NavItem, NavLink } from 'reactstrap';
import { withI18n } from 'react-i18next';
import Editor from './Editor';
import Console from './Console';
import Solution from './Solution';
import withActive from '../hoc/withActive';
import connect from '../connect';

const mapStateToProps = (state) => {
  const { checkInfo, currentTabInfo } = state;
  const props = { checkInfo, currentTabInfo };
  return props;
};

@connect(mapStateToProps)
@withI18n()
@withActive()
class TabsBox extends React.Component {
  render() {
    const {
      checkInfo,
      currentTabInfo,
      t,
      setActive,
      changeCode,
      userFinishedLesson,
      lesson,
      language,
    } = this.props;

    const activateNavLink = this.props.activeClass('active d-flex x-flex-1');
    const activateTabPane = this.props.activeClass('d-flex x-flex-1');

    return (
      <div className="d-flex flex-column x-flex-1 h-100 mb-2">
        <Nav tabs>
          <NavItem>
            <NavLink href="#" onClick={setActive('editor')} className={activateNavLink('editor')}>{t('editor')}</NavLink>
          </NavItem>
          <NavItem>
            <NavLink href="#" onClick={setActive('console')} className={activateNavLink('console')}>{t('console')}</NavLink>
          </NavItem>
          <NavItem>
            <NavLink href="#" onClick={setActive('solution')} className={activateNavLink('solution')}>{t('solution')}</NavLink>
          </NavItem>
        </Nav>
        <TabContent className="d-flex x-flex-1 overflow-hidden" activeTab={this.props.active}>
          <TabPane tabId="editor" className={activateTabPane('editor')}>
            <Editor
              defaultValue={lesson.prepared_code}
              onCodeChange={changeCode}
              language={language.slug}
              current={currentTabInfo.current === 'editor'}
              clicksCount={currentTabInfo.clicksCount}
            />
          </TabPane>
          <TabPane tabId="console" className={activateTabPane('console')}>
            <Console className="hexlet-basics-tab-content d-flex x-flex-1 p-2" output={checkInfo.output} />
          </TabPane>
          <TabPane tabId="solution" className={activateTabPane('solution')}>
            <Solution
              defaultValue={lesson.original_code}
              language={language.slug}
              userFinishedLesson={userFinishedLesson}
            />
          </TabPane>
        </TabContent>
      </div>
    );
  }
}

export default TabsBox;
