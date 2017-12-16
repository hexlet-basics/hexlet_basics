import React from 'react';
import PropTypes from 'prop-types';
// import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import { TabContent, TabPane, Nav, NavItem, NavLink } from 'reactstrap';
import Editor from './Editor.jsx';
import Console from './Console.jsx';
import withActive from '../hoc/withActive.jsx';
// import md from '../../lib/markdown';

class TabsBox extends React.Component {
  render() {
    const { lesson, language } = this.context;
    const { checkInfo, currentTabInfo } = this.props;

    const activate = this.props.activeClass('active');

    return (<div className="d-flex flex-column x-flex-1 h-100 mb-2">
      <Nav tabs>
        <NavItem>
          <NavLink href="#" {...activate('editor', { default: true })}>Code</NavLink>
        </NavItem>
        <NavItem>
          <NavLink href="#" {...activate('console')}>Console</NavLink>
        </NavItem>
      </Nav>
      <TabContent className="d-flex x-flex-1" activeTab={this.props.active}>
        <TabPane tabId="editor">
          <Editor
            defaultValue={lesson.prepared_code}
            onCodeChange={this.props.changeCode}
            language={language.slug}
            current={currentTabInfo.index === 0}
          />
        </TabPane>
        <TabPane className="d-flex x-flex-1" tabId="console">
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

export default withActive(TabsBox);
