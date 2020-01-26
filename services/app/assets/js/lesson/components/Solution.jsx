// @ts-check

import React from 'react';
// import cn from 'classnames';
import { Highlight } from 'react-fast-highlight';
import Countdown, { zeroPad } from 'react-countdown';
import { get } from 'lodash';
import { withTranslation } from 'react-i18next';
// import formatDistanceStrict from 'date-fns/formatDistanceStrict';
// import dateFnsLocale from '../../lib/data-fns-locale';
import connect from '../connect';

const languageMapping = {
  racket: 'scheme',
};

const mapStateToProps = (state) => {
  const {
    editor,
    solutionState,
    // countdown,
  } = state;
  const props = {
    editor,
    solutionState,
    // countdown,
  };
  return props;
};

@connect(mapStateToProps)
@withTranslation()
class Solution extends React.Component {
  handleShowSolution = () => {
    const { showSolution } = this.props;
    showSolution();
  }

  renderUserCode(t) {
    const { editor, language } = this.props;
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
  }

  renderSolution(props) {
    const { language, defaultValue, t } = props;
    const mappedLanguage = get(languageMapping, language, language);

    return (
      <div className="p-3 pt-2 x-overflow-y-scroll" id="basics-solution">
        <p className="mb-0">{t('teacher_solution')}</p>
        <Highlight languages={[mappedLanguage]}>
          {defaultValue}
        </Highlight>
        {this.renderUserCode(t)}
      </div>
    );
  }

  renderShowButton(props) {
    const { t } = props;
    return (
      <>
        <p>{t('solution_notice')}</p>
        <div className="text-center">
          <button
            type="button"
            className="btn btn-secondary px-4 mr-3"
            onClick={this.handleShowSolution}
          >
            {t('show_solution')}
          </button>
        </div>
      </>
    );
  }

  renderContent = (props) => (countdownData) => {
    const { solutionState, t } = props;
    const { minutes, seconds, completed } = countdownData;

    if (solutionState.shown) {
      return this.renderSolution(props);
    }
    if (completed || solutionState.canBeShown) {
      return this.renderShowButton(props);
    }

    const remainingTime = `${zeroPad(minutes)}:${zeroPad(seconds)}`;

    return <p>{t('solution_instructions', { remainingTime })}</p>;
  }

  render() {
    const {
      startTime,
    } = this.props;

    const waitingTime = 20 * 60 * 1000;

    return (
      <div className="p-3 pt-2 d-flex flex-column flex-fill h-100 w-100">
        <Countdown date={startTime + waitingTime} renderer={this.renderContent(this.props)} />
      </div>
    );
  }
}

export default Solution;
