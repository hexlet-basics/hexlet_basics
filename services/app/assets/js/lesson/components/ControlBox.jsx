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
  const { checkInfo, editor, lessonState } = state;
  const props = { checkInfo, editor, lessonState };
  return props;
};

const renderRunButtonContent = ({ checkInfo }, t) => {
  const text = t('run');
  if (checkInfo.processing) {
    return (
      <>
        <Spinner className="mr-1" as="span" animation="border" size="sm" role="status" aria-hidden="true" />
        <span className="sr-only">Loading...</span>
        {text}
      </>
    );
  }

  return (
    <>
      <i className="fas fa-play-circle mr-1" />
      {text}
    </>
  );
};

@connect(mapStateToProps)
@withTranslation()
class ControlBox extends React.Component {
  static contextType = EntityContext;

  handleRunCheck = () => {
    const { editor, runCheck } = this.props;
    const { lesson } = this.context;
    runCheck({ lesson, editor });
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
              {renderRunButtonContent(this.props, t)}
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
