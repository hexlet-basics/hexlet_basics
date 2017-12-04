import React from 'react';
import PropTypes from 'prop-types';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
// import ReactDisqusComments from 'react-disqus-comments';
import Editor from './Editor.jsx';
import Console from './Console.jsx';
// import md from '../../lib/markdown';

export default class TabsBox extends React.Component {
  render() {
    const { lesson, language } = this.context;

    const tabPanelSelectedClasses = 'd-flex x-flex-1';

    return (<Tabs className="d-flex flex-column x-flex-1 h-100" selectedTabClassName="active">
      <TabList className="nav nav-tabs" >
        <Tab className="nav-item nav-link"><a href="#">Code</a></Tab>
        <Tab className="nav-item nav-link"><a href="#">Console</a></Tab>
      </TabList>
      <TabPanel className="d-none" selectedClassName={tabPanelSelectedClasses}>
        <Editor border-dark defaultValue={lesson.prepared_code} language={language.slug} />
      </TabPanel>
      <TabPanel className="d-none" selectedClassName={tabPanelSelectedClasses}>
        <Console />
      </TabPanel>
    </Tabs>);
  }
}

TabsBox.contextTypes = {
  lesson: PropTypes.object,
  language: PropTypes.object,
};
