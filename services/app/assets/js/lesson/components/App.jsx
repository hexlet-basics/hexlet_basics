// @ts-check

import React from 'react';
import { Alert, AlertContainer } from 'react-bs-notifier';
import { withTranslation } from 'react-i18next';
import connect from '../connect';
import TabsBox from './TabsBox';
import HTMLPreview from './HTMLPreview';
import ControlBox from './ControlBox';

const mapStateToProps = (state) => {
  const { notification, code, checkInfo, currentTabInfo } = state;
  const props = { notification, code, checkInfo, currentTabInfo };
  return props;
};

const getViewOptions = (languageName, props) => {
  switch (languageName) {
    case 'html':
      return {
        tabsBoxClassName: 'h-50',
        component: <HTMLPreview html={props.code} />,
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

  renderAlert() {
    const { notification, dismissNotification, t } = this.props;
    if (!notification) {
      return null;
    }
    return (
      <div className="hexlet-ide-notifications">
        <AlertContainer>
          <Alert
            timeout={5000}
            onDismiss={dismissNotification}
            type={notification.type}
            headline={t(notification.headline)}
          >
            {t(notification.message)}
          </Alert>
        </AlertContainer>
      </div>
    );
  }

  render() {
    const { currentTabInfo, userFinishedLesson, language } = this.props;

    const currentViewOptions = getViewOptions(language.name, this.props);

    return (
      <React.Fragment>
        {this.renderAlert()}
        <TabsBox
          className={currentViewOptions.tabsBoxClassName}
          onSelectActive={this.handleSelectTab}
          active={currentTabInfo.current}
          userFinishedLesson={userFinishedLesson}
        />
        {currentViewOptions.component}
        <div className="mt-2">
          <ControlBox userFinishedLesson={userFinishedLesson} />
        </div>
      </React.Fragment>
    );
  }
}

export default App;
