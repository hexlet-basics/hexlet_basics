import React from 'react';
import PropTypes from 'prop-types';
import { Alert, AlertContainer } from 'react-bs-notifier';
import { translate } from 'react-i18next';
import TabsBoxContainer from '../containers/TabsBox';
import ControlBoxContainer from '../containers/ControlBox';

class App extends React.Component {
  getChildContext() {
    return {
      language: this.props.language,
      lesson: this.props.lesson,
    };
  }

  handleSelectTab = (current) => {
    this.props.selectTab({ current });
  }

  renderAlert() {
    const { notification, t } = this.props;
    if (!notification) {
      return null;
    }
    return (<AlertContainer>
      <Alert timeout={5000} onDismiss={this.props.dismissNotification} className="hexlet-ide-notifications" type={notification.type} headline={t(notification.headline)}>
        {t(notification.message)}
      </Alert>
    </AlertContainer>);
  }

  render() {
    const { currentTabInfo } = this.props;

    return (<React.Fragment>
      {this.renderAlert()}
      <TabsBoxContainer onSelectActive={this.handleSelectTab} active={currentTabInfo.current} />
      <ControlBoxContainer />
    </React.Fragment>);
  }
}

App.childContextTypes = {
  lesson: PropTypes.object,
  language: PropTypes.object,
};

export default translate()(App);
