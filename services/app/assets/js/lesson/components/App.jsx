import React from 'react';
import PropTypes from 'prop-types';
import { Alert, AlertContainer } from 'react-bs-notifier';
import { translate } from 'react-i18next';
import connect from '../connect';
import TabsBox from '../components/TabsBox';
import ControlBox from '../components/ControlBox';
import EntityContext from '../EntityContext';

const mapStateToProps = (state) => {
  const { notification, checkInfo, currentTabInfo } = state;
  const props = { notification, checkInfo, currentTabInfo };
  return props;
};

@connect(mapStateToProps)
@translate()
class App extends React.Component {
  handleSelectTab = (current) => {
    this.props.selectTab({ current });
  }

  renderAlert() {
    const { notification, t } = this.props;
    if (!notification) {
      return null;
    }
    return (
      <div className="hexlet-ide-notifications">
        <AlertContainer>
          <Alert
            timeout={5000}
            onDismiss={this.props.dismissNotification}
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
    const { currentTabInfo, userFinishedLesson } = this.props;

    return (
      <React.Fragment>
        {this.renderAlert()}
        <EntityContext.Consumer>
          {({ lesson, language }) => (<TabsBox
            lesson={lesson}
            language={language}
            onSelectActive={this.handleSelectTab}
            active={currentTabInfo.current}
            userFinishedLesson={userFinishedLesson}
          />)}
        </EntityContext.Consumer>
        <EntityContext.Consumer>
          {entities => <ControlBox {...entities} userFinishedLesson={userFinishedLesson} />}
        </EntityContext.Consumer>
      </React.Fragment>
    );
  }
}

export default App;
