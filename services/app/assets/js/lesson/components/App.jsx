import React from 'react';
import PropTypes from 'prop-types';
import { Alert, AlertContainer } from 'react-bs-notifier';
import TabsBoxContainer from '../containers/TabsBox';
import ControlBoxContainer from '../containers/ControlBox';
import SideBar from './SideBar.jsx';

export default class App extends React.Component {
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
    const { notification } = this.props;
    if (!notification) {
      return null;
    }
    return (<AlertContainer>
      <Alert timeout={5000} onDismiss={this.props.dismissNotification} className="hexlet-ide-notifications" type={notification.type} headline={notification.headline}>
        {notification.message}
      </Alert>
    </AlertContainer>);
  }

  render() {
    const { currentTabInfo, lesson } = this.props;

    return (
      <React.Fragment>
        {this.renderAlert()}
        <div className="row">
          <div className="col-5">
            <SideBar lesson={lesson} />
          </div>
          <div className="col-7 no-gutters pl-0 d-flex flex-column">
            <TabsBoxContainer onSelectActive={this.handleSelectTab} active={currentTabInfo.current} />
            <ControlBoxContainer />
          </div>
        </div>
      </React.Fragment>);
  }
}

App.childContextTypes = {
  lesson: PropTypes.object,
  language: PropTypes.object,
};
