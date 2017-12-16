import React from 'react';
import PropTypes from 'prop-types';
import cn from 'classnames';
import FontAwesomeIcon from '@fortawesome/react-fontawesome';
import { faSpinner, faPlayCircle } from '@fortawesome/fontawesome-free-solid';

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
        <div className="col x-font-sans-serif">
          <button className={runButtonClasses} onClick={this.handleRunCheck}>
            <span className="text-secondary x-1em-inline-block mr-2">
              { checkInfo.processing && <FontAwesomeIcon icon={faSpinner} spin /> }
              { !checkInfo.processing && <FontAwesomeIcon icon={faPlayCircle} /> }
            </span>
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
