import React from 'react';
import PropTypes from 'prop-types';
import cn from 'classnames';
import FontAwesomeIcon from '@fortawesome/react-fontawesome';
import { faSpinner, faPlayCircle } from '@fortawesome/fontawesome-free-solid';
import { translate } from 'react-i18next';
import Hotkeys from 'react-hot-keys';
import connect from '../connect';

const mapStateToProps = (state) => {
  const { checkInfo, code, lessonState } = state;
  const props = { checkInfo, code, lessonState };
  return props;
};

@connect(mapStateToProps)
@translate()
class ControlBox extends React.Component {
  static contextTypes = {
    lesson: PropTypes.object,
  };

  handleRunCheck = () => {
    const { code } = this.props;
    const { lesson } = this.context;
    this.props.runCheck({ lesson, code });
  }

  render() {
    const {
      checkInfo,
      lessonState,
      t,
    } = this.props;
    const { lesson } = this.context;

    const runButtonClasses = cn({
      'btn btn-primary x-no-focus-outline x-cursor-pointer px-4 mr-3': true,
      disabled: checkInfo.processing,
    });

    const nextButtonClasses = cn({
      btn: true,
      'btn-outline-secondary disabled': !lessonState.finished,
      'btn-success': lessonState.finished,
    });

    // TODO move to js routes
    const nextLessonUrl = `/lessons/${lesson.id}/redirect-to-next`;


    return (
      <Hotkeys keyName="ctrl+Enter" onKeyUp={this.handleRunCheck}>
        <div className="row">
          <div className="col x-font-sans-serif">
            <button className={runButtonClasses} onClick={this.handleRunCheck}>
              <span className="text-secondary x-1em-inline-block mr-2">
                { checkInfo.processing && <FontAwesomeIcon icon={faSpinner} spin /> }
                { !checkInfo.processing && <FontAwesomeIcon icon={faPlayCircle} /> }
              </span>
              {t('run')}
            </button>
            <a className={nextButtonClasses} href={nextLessonUrl}>
              {t('next_lesson')}
            </a>
          </div>
        </div>
      </Hotkeys>
    );
  }
}

export default ControlBox;
