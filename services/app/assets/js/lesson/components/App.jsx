// @ts-check

import React from 'react';
import { withTranslation } from 'react-i18next';
import connect from '../connect';
import TabsBox from './TabsBox';
import HTMLPreview from './HTMLPreview';
import ControlBox from './ControlBox';

const mapStateToProps = (state) => {
  const { code, checkInfo, currentTabInfo } = state;
  const props = { code, checkInfo, currentTabInfo };
  return props;
};

const getViewOptions = (languageName, props) => {
  switch (languageName) {
    case 'css':
    case 'html':
      return {
        tabsBoxClassName: 'h-50',
        component: <HTMLPreview html={props.code.content} />,
      };
    default:
      return {
        tabsBoxClassName: 'h-100',
        component: null,
      }
  }
}


@connect(mapStateToProps)
@withTranslation()
class App extends React.Component {
  handleSelectTab = (current) => {
    const { selectTab } = this.props;
    selectTab({ current });
  }

  render() {
    const { currentTabInfo, userFinishedLesson, language, startTime } = this.props;

    const currentViewOptions = getViewOptions(language.name, this.props);

    return (
      <>
        <TabsBox
          startTime={startTime}
          className={currentViewOptions.tabsBoxClassName}
          onSelectActive={this.handleSelectTab}
          active={currentTabInfo.current}
          userFinishedLesson={userFinishedLesson}
        />
        {currentViewOptions.component}
        <ControlBox userFinishedLesson={userFinishedLesson} />
      </>
    );
  }
}

export default App;
