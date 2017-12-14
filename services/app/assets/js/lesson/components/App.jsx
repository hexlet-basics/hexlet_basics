import React from 'react';
import PropTypes from 'prop-types';
import { Alert, AlertContainer } from 'react-bs-notifier';
import TabsBoxContainer from '../containers/TabsBox';
import ControlBoxContainer from '../containers/ControlBox';
import md from '../../lib/markdown';


export default class App extends React.Component {
  getChildContext() {
    return {
      language: this.props.language,
      lesson: this.props.lesson,
    };
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
    const { lesson } = this.props;
    const theory = md(lesson.theory);
    const instructions = md(lesson.instructions);

    return (
      <React.Fragment>
        {this.renderAlert()}
        <div className="row">
          <div className="col-5">
            <div className="card hexlet-basics-theory-card">
              <h4 className="card-header">
                {lesson.name}
              </h4>
              <div className="card-body x-overflow-y-scroll">
                <h5 className="card-title">Теория</h5>
                <div className="card-text" dangerouslySetInnerHTML={{ __html: theory }} />
                <h5 className="card-title">Инструкции</h5>
                <div className="card-text" dangerouslySetInnerHTML={{ __html: instructions }} />
              </div>
            </div>
          </div>
          <div className="col-7 no-gutters pl-0 d-flex flex-column">
            <TabsBoxContainer />
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
