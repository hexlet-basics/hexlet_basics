// @ts-check

import React from 'react';
import cn from 'classnames';
import { withTranslation } from 'react-i18next';
import Hotkeys from 'react-hot-keys';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import connect from '../connect';
import routes from '../routes';
import EntityContext from '../EntityContext';

const mapStateToProps = (state) => {
  const { checkInfo, code, lessonState } = state;
  const props = { checkInfo, code: code.content, lessonState };
  return props;
};

@connect(mapStateToProps)
@withTranslation()
class ControlBox extends React.Component {
  static contextType = EntityContext;

  handleRunCheck = () => {
    const { code, runCheck } = this.props;
    const { lesson } = this.context;
    runCheck({ lesson, code });
  }

  render() {
    const {
      checkInfo,
      lessonState,
      t,
    } = this.props;

    const {
      language,
      lesson,
      prevLesson,
    } = this.context;

    const runButtonClasses = cn({
      'btn btn-black px-md-4 mx-md-3 flex-fill': true,
      disabled: checkInfo.processing,
    });

    const nextButtonClasses = cn({
      'btn text-light d-inline-flex align-items-center': true,
      'btn-outline-black disabled': !lessonState.finished,
      'btn-success': lessonState.finished,
    });

    const prevButtonClasses = cn({
      'btn text-light d-inline-flex align-items-center': true,
      'btn-outline-black disabled': !prevLesson,
      'btn-success': prevLesson,
    });

    // TODO move to js routes
    const nextLessonPath = routes.nextLessonPath(lesson);
    const prevLessonPath = prevLesson ? routes.languageModuleLessonPath(language, prevLesson.module, prevLesson) : '#';


    return (
      <Hotkeys keyName="ctrl+Enter" onKeyUp={this.handleRunCheck}>
        <div className="row">
          <div className="col d-flex d-xl-block x-font-sans-serif text-center py-2">
            <a
              className="btn btn-outline-secondary mr-xl-3 d-inline-flex align-items-center"
              href={window.location.href}
              title={t('reset_code')}
              data-confirm={t('confirm')}
            >
              <FontAwesomeIcon icon="sync-alt" />
            </a>
            <a className={prevButtonClasses} href={prevLessonPath}>
              <FontAwesomeIcon icon="chevron-circle-left" className="mr-xl-2" />
              <span className="d-none d-xl-inline">{t('prev_lesson')}</span>
            </a>
            <button type="button" className={runButtonClasses} onClick={this.handleRunCheck}>
              <span className="text-secondary x-1em-inline-block mr-2">
                {checkInfo.processing && <FontAwesomeIcon icon="spinner" pulse />}
                {!checkInfo.processing && <FontAwesomeIcon icon="play-circle" />}
              </span>
              <span className="">{t('run')}</span>
            </button>
            <a className={nextButtonClasses} href={nextLessonPath}>
              <span className="d-none d-xl-inline">{t('next_lesson')}</span>
              <FontAwesomeIcon icon="chevron-circle-right" className="ml-xl-2" />
            </a>
          </div>
        </div>
      </Hotkeys>
    );
  }
}

export default ControlBox;
