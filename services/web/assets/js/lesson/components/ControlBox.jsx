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

const ControlBox = () => {
  const { t } = useTranslation();
  const { lesson, language, prevLesson } = useContext(EntityContext);
  const { checkInfo, lessonState, editor } = useSelector((state) => state);
  const { useCheckInfoActions } = asyncActions;
  const { runCheck } = useCheckInfoActions();

  const handleRunCheck = () => {
    runCheck({ lesson, editor });
  };

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
    <Hotkeys keyName="ctrl+Enter" onKeyUp={handleRunCheck}>
      <div className="mx-auto align-items-center d-flex text-center mt-1">
        <a
          className="btn btn-outline-secondary mr-3"
          href={window.location.href}
          title={t('reset_code')}
          data-confirm={t('confirm')}
        >
          <i className="fas fa-sync-alt" />
        </a>
        <a className={prevButtonClasses} href={prevLessonPath}>
          <span>{t('prev_lesson')}</span>
        </a>
        <Button variant="primary" className="mr-3" onClick={handleRunCheck} disabled={checkInfo.processing}>
          {renderRunButtonContent({ checkInfo }, t)}
        </Button>
        <a className={nextButtonClasses} href={nextLessonPath}>
          <span>{t('next_lesson')}</span>
        </a>
      </div>
    </Hotkeys>
  );
};

export default ControlBox;
