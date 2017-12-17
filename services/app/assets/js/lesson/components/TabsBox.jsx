import React from 'react';
import PropTypes from 'prop-types';
import { TabContent, TabPane, Nav, NavItem, NavLink } from 'reactstrap';
import cn from 'classnames';
import { translate } from 'react-i18next';
import Editor from './Editor.jsx';
import Console from './Console.jsx';
import withActive from '../hoc/withActive.jsx';
// import md from '../../lib/markdown';

class TabsBox extends React.Component {
  render() {
    const { lesson, language } = this.context;
    const { checkInfo, currentTabInfo, t, setActive } = this.props;

    const activateNavLink = this.props.activeClass('active d-flex x-flex-1');
    const activateTabPane = this.props.activeClass('d-flex x-flex-1');

    return (<div className="d-flex flex-column x-flex-1 h-100 mb-2">
      <Nav tabs>
        <NavItem>
          <NavLink href="#" onClick={setActive('editor')} className={activateNavLink('editor')}>{t('editor')}</NavLink>
        </NavItem>
        <NavItem>
          <NavLink href="#" onClick={setActive('console')} className={activateNavLink('console')}>{t('console')}</NavLink>
        </NavItem>
      </Nav>
      <TabContent className="d-flex x-flex-1" activeTab={this.props.active}>
        <TabPane tabId="editor" className={activateTabPane('editor')}>
          <Editor
            defaultValue={lesson.prepared_code}
            onCodeChange={this.props.changeCode}
            language={language.slug}
            current={currentTabInfo.current === 'editor'}
            clicksCount={currentTabInfo.clicksCount}
          />
        </TabPane>
        <TabPane tabId="console" className={activateTabPane('console')}>
          <Console className="hexlet-basics-tab-content d-flex x-flex-1 p-2" output={checkInfo.output} />
        </TabPane>
      </TabContent>
    </div>);
  }
}

TabsBox.contextTypes = {
  lesson: PropTypes.object,
  language: PropTypes.object,
};

export default translate()(withActive()(TabsBox));
