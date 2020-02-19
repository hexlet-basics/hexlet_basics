// @ts-check

import React from 'react';
import { useTranslation } from 'react-i18next';
import { useSelector } from 'react-redux';
// import cn from 'classnames';
import { Highlight } from 'react-fast-highlight';
import Countdown, { zeroPad } from 'react-countdown';
import { get } from 'lodash';
// import formatDistanceStrict from 'date-fns/formatDistanceStrict';
// import dateFnsLocale from '../../lib/data-fns-locale';
import connect from '../connect';

const languageMapping = {
  racket: 'scheme',
};

/**
 * @param {Object} props
 */
const Solution = (props) => {
  const {
    startTime,
    defaultValue,
    language,
    showSolution,
  } = props;

  const { t } = useTranslation();
  const { editor, solutionState } = useSelector((state) => state);

  const handleShowSolution = () => showSolution();

  const renderUserCode = () => {
    if (!editor.content) {
      return <p className="mt-3">{t('user_code_instructions')}</p>;
    }

    const mappedLanguage = get(languageMapping, language, language);

    return (
      <div>
        <p className="mt-3 mb-0">{t('user_code')}</p>
        <Highlight languages={[mappedLanguage]}>
          {editor.content}
        </Highlight>
      </div>
    );
  };

  const renderSolution = () => {
    const mappedLanguage = get(languageMapping, language, language);

    return (
      <div className="p-3 pt-2 x-overflow-y-scroll" id="basics-solution">
        <p className="mb-0">{t('teacher_solution')}</p>
        <Highlight languages={[mappedLanguage]}>
          {defaultValue}
        </Highlight>
        {renderUserCode()}
      </div>
    );
  };

  const renderShowButton = () => (
    <>
      <p>{t('solution_notice')}</p>
      <div className="text-center">
        <button
          type="button"
          className="btn btn-secondary px-4 mr-3"
          onClick={handleShowSolution}
        >
          {t('show_solution')}
        </button>
      </div>
    </>
  );

  /**
   * @param {Object} countdownData
   */
  const renderContent = () => (countdownData) => {
    const { minutes, seconds, completed } = countdownData;

    if (solutionState.shown) {
      return renderSolution();
    }
    if (completed || solutionState.canBeShown) {
      return renderShowButton();
    }

    const remainingTime = `${zeroPad(minutes)}:${zeroPad(seconds)}`;

    return <p>{t('solution_instructions', { remainingTime })}</p>;
  };

  const waitingTime = 20 * 60 * 1000;

  return (
    <div className="p-3 pt-2 d-flex flex-column flex-fill h-100 w-100">
      <Countdown date={startTime + waitingTime} renderer={renderContent()} />
    </div>
  );
};

export default connect()(Solution);
