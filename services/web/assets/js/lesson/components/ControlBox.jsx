// @ts-check

import React, { useContext } from 'react';
import { useTranslation } from 'react-i18next';
import { useSelector } from 'react-redux';
import cn from 'classnames';
import Hotkeys from 'react-hot-keys';
import { Button, Spinner } from 'react-bootstrap';
import { asyncActions } from '../slices';
import routes from '../routes';
import EntityContext from '../EntityContext';

const renderRunButtonContent = ({ checkInfo }, t) => {
  const text = t('run');
  if (checkInfo.processing) {
    return (
      <>
        <Spinner as="span" animation="border" size="sm" role="status" aria-hidden="true" />
        <span className="sr-only">Loading...</span>
        <span className="d-none d-sm-block d-md-none d-lg-block ml-1">{text}</span>
      </>
    );
  }

  return (
    <>
      <span className="fas fa-play-circle" />
      <span className="d-none d-sm-block d-md-none d-lg-block ml-1">{text}</span>
    </>
  );
};

const ControlBox = () => {
  const { t } = useTranslation();
  const { lesson, language, prevLesson } = useContext(EntityContext);
  const { checkInfo, lessonState, editor } = useSelector((state) => state);
  const { useCheckInfoActions } = asyncActions;
  const { runCheck } = useCheckInfoActions();

  const handleRunCheck = () => {
    runCheck({ lesson, editor });
  };

  const prevButtonClasses = cn('btn btn-outline-secondary font-weight-normal mr-3 order-first order-sm-0 order-md-first order-lg-0', {
    'disabled': !prevLesson,
  });

  const nextButtonClasses = cn('btn btn-outline-primary font-weight-normal', {
    'disabled': !lessonState.finished,
  });

  // TODO move to js routes
  const nextLessonPath = routes.nextLessonPath(lesson);
  const prevLessonPath = prevLesson ? routes.languageModuleLessonPath(language, prevLesson.module, prevLesson) : '#';

  return (
    <Hotkeys keyName="ctrl+Enter" onKeyUp={handleRunCheck}>
      <div className="mx-auto d-flex align-items-center text-center my-3">
        <a
          className="btn btn-outline-secondary mr-3"
          href={window.location.href}
          title={t('reset_code')}
          data-confirm={t('confirm')}
        >
          <span className="fas fa-sync-alt" />
          <span className="d-none d-sm-block d-md-none d-lg-block">&nbsp;</span>
        </a>
        <a className={prevButtonClasses} href={prevLessonPath}>
          <span className="d-sm-none d-md-block d-lg-none fas fa-arrow-left" />
          <span className="d-none d-sm-block d-md-none d-lg-block">{t('prev_lesson')}</span>
        </a>
        <Button variant="primary" className="mr-3" onClick={handleRunCheck} disabled={checkInfo.processing}>
          {renderRunButtonContent({ checkInfo }, t)}
        </Button>
        <a className={nextButtonClasses} href={nextLessonPath}>
          <span className="d-sm-none d-md-block d-lg-none fas fa-arrow-right" />
          <span className="d-none d-sm-block d-md-none d-lg-block">{t('next_lesson')}</span>
        </a>
      </div>
    </Hotkeys>
  );
};

export default ControlBox;
