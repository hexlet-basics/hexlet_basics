// @ts-check

import React from 'react';
import cn from 'classnames';
import { withTranslation } from 'react-i18next';
import Hotkeys from 'react-hot-keys';
import { Button, Spinner } from 'react-bootstrap';
import connect from '../connect';
import routes from '../routes';
import EntityContext from '../EntityContext';

const mapStateToProps = (state) => {
  const { checkInfo, code, lessonState } = state;
  const props = { checkInfo, code, lessonState };
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

    const nextButtonClasses = cn({
      'text-muted disabled': !lessonState.finished,
    });

    const prevButtonClasses = cn('mr-3', {
      'text-muted disabled': !prevLesson,
    });

    // TODO move to js routes
    const nextLessonPath = routes.nextLessonPath(lesson);
    const prevLessonPath = prevLesson ? routes.languageModuleLessonPath(language, prevLesson.module, prevLesson) : '#';


    return (
      <Hotkeys keyName="ctrl+Enter" onKeyUp={this.handleRunCheck}>
        <div className="row">
          <div className="col d-flex d-xl-block text-center mt-1">
            <a
              className="btn btn-outline-secondary mr-xl-3 d-inline-flex align-items-center"
              href={window.location.href}
              title={t('reset_code')}
              data-confirm={t('confirm')}
            >
              <i className="fas fa-sync-alt" />
            </a>
            <a className={prevButtonClasses} href={prevLessonPath}>
              <span className="d-none d-xl-inline">{t('prev_lesson')}</span>
            </a>
            <Button variant="primary" className="mr-3" onClick={this.handleRunCheck} disabled={checkInfo.processing}>
              {checkInfo.processing && <Spinner
                as="span"
                animation="border"
                size="sm"
                role="status"
                aria-hidden="true"
              />}
              <span className="sr-only">Loading...</span>
              {t('run')}
            </Button>
            <a className={nextButtonClasses} href={nextLessonPath}>
              <span className="d-none d-xl-inline">{t('next_lesson')}</span>
            </a>
          </div>
        </div>
      </Hotkeys>
    );
  }
}

export default ControlBox;
