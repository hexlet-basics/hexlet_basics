import React from 'react';
import PropTypes from 'prop-types';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import Editor from './Editor.jsx';
import Console from './Console.jsx';
// import md from '../../lib/markdown';

export default class TabsBox extends React.Component {
  handleSelectTab = (index) => {
    this.props.selectTab({ index });
  }
  render() {
    const { lesson, language } = this.context;
    const { checkInfo, currentTabInfo } = this.props;

    const tabPanelSelectedClasses = 'd-flex x-flex-1';
    return (<Tabs
      className="d-flex flex-column x-flex-1 h-100 mb-2"
      onSelect={this.handleSelectTab}
      selectedIndex={currentTabInfo.index}
      forceRenderTabPanel
      selectedTabClassName="active"
    >
      <TabList className="nav nav-tabs" >
        <Tab className="nav-item nav-link"><a href="#">Code</a></Tab>
        <Tab className="nav-item nav-link"><a href="#">Console</a></Tab>
      </TabList>
      <TabPanel className="d-none" selectedClassName={tabPanelSelectedClasses}>
        <Editor
          defaultValue={lesson.prepared_code}
          onCodeChange={this.props.changeCode}
          language={language.slug}
          current={currentTabInfo.index === 0}
        />
      </TabPanel>
      <TabPanel className="d-none hexlet-basics-tab-content x-overflow p-2" selectedClassName={tabPanelSelectedClasses}>

        <Console output={checkInfo.output} />
      </TabPanel>
    </Tabs>);
  }
}

TabsBox.contextTypes = {
  lesson: PropTypes.object,
  language: PropTypes.object,
};
