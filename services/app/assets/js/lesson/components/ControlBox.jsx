import React from 'react';
import cn from 'classnames';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSpinner, faPlayCircle, faSyncAlt } from '@fortawesome/free-solid-svg-icons';
import { translate } from 'react-i18next';
import Hotkeys from 'react-hot-keys';
import connect from '../connect';
import routes from '../routes';

const mapStateToProps = (state) => {
  const { checkInfo, code, lessonState } = state;
  const props = { checkInfo, code, lessonState };
  return props;
};

@connect(mapStateToProps)
@translate()
class ControlBox extends React.Component {
  handleRunCheck = () => {
    const { code, lesson } = this.props;
    this.props.runCheck({ lesson, code });
  }

  render() {
    const {
      checkInfo,
      lessonState,
      t,
      language,
      lesson,
      prevLesson,
    } = this.props;

    const runButtonClasses = cn({
      'btn btn-primary x-no-focus-outline px-4 mx-3': true,
      disabled: checkInfo.processing,
    });

    const nextButtonClasses = cn({
      btn: true,
      'btn-outline-secondary disabled': !lessonState.finished,
      'btn-success': lessonState.finished,
    });

    const prevButtonClasses = cn({
      btn: true,
      'btn-outline-secondary disabled': !prevLesson,
      'btn-success': prevLesson,
    });

    // TODO move to js routes
    const nextLessonPath = routes.nextLessonPath(lesson);
    const prevLessonPath = prevLesson ? routes.languageModuleLessonPath(language, prevLesson.module, prevLesson) : '#';


    return (
      <Hotkeys keyName="ctrl+Enter" onKeyUp={this.handleRunCheck}>
        <div className="row">
          <div className="col x-font-sans-serif text-center">
            <a
              className="btn btn-outline-primary mr-3"
              href={window.location}
              title={t('reset_code')}
              data-confirm={t('confirm')}
            >
              <FontAwesomeIcon icon={faSyncAlt} />
            </a>
            <a className={prevButtonClasses} href={prevLessonPath}>
              {t('prev_lesson')}
            </a>
            <button className={runButtonClasses} onClick={this.handleRunCheck}>
              <span className="text-secondary x-1em-inline-block mr-2">
                { checkInfo.processing && <FontAwesomeIcon icon={faSpinner} spin /> }
                { !checkInfo.processing && <FontAwesomeIcon icon={faPlayCircle} /> }
              </span>
              {t('run')}
            </button>
            <a className={nextButtonClasses} href={nextLessonPath}>
              {t('next_lesson')}
            </a>
          </div>
        </div>
      </Hotkeys>
    );
  }
}

export default ControlBox;
