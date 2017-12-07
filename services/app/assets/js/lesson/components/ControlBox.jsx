import React from 'react';
import PropTypes from 'prop-types';
import cn from 'classnames';

class ControlBox extends React.Component {
  handleRunCheck = () => {
    const { code } = this.props;
    this.props.runCheck({ code });
  }

  render() {
    const { checkInfo, finished } = this.props;
    const { lesson } = this.context;

    const runButtonClasses = cn({
      'btn btn-outline-primary mr-3': true,
      disabled: checkInfo.processing,
    });

    const nextButtonClasses = cn({
      'btn btn-outline-success': true,
      disabled: !finished,
    });

    const nextLessonUrl = `/lessons/${lesson.id}/redirect-to-next`;

    return (
      <div className="row">
        <div className="col">
          <button className={runButtonClasses} onClick={this.handleRunCheck}>Run</button>
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
