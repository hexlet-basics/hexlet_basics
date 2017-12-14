import React from 'react';
import PropTypes from 'prop-types';
import cn from 'classnames';
import FontAwesomeIcon from '@fortawesome/react-fontawesome';
import { faSpinner } from '@fortawesome/fontawesome-free-solid';

class ControlBox extends React.Component {
  handleRunCheck = () => {
    const { code } = this.props;
    const { lesson } = this.context;
    this.props.runCheck({ lesson, code });
  }

  render() {
    const { checkInfo, finished } = this.props;
    const { lesson } = this.context;

    // console.log('asdf')
    const runButtonClasses = cn({
      'btn btn-primary x-no-focus-outline x-cursor-pointer px-4 mr-3': true,
      disabled: checkInfo.processing,
    });

    const nextButtonClasses = cn({
      btn: true,
      'btn-outline-success disabled': !finished,
      'btn-success': finished,
    });

    // TODO move to  js routes
    const nextLessonUrl = `/lessons/${lesson.id}/redirect-to-next`;


    return (
      <div className="row">
        <div className="col">
          <button className={runButtonClasses} onClick={this.handleRunCheck}>
            { checkInfo.processing && <FontAwesomeIcon className="mr-1" icon={faSpinner} spin /> }
            Run
          </button>
          <a className={nextButtonClasses} href={nextLessonUrl}>Next Lesson</a>
        </div>
      </div>
    );
  }
}

ControlBox.contextTypes = {
  lesson: PropTypes.object,
};

export default ControlBox;
