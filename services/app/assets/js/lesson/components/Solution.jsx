// @ts-check

import React from 'react';
import cn from 'classnames';
import { Highlight } from 'react-fast-highlight';
import Countdown from 'react-countdown';
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
    code,
    solutionState,
    // countdown,
  } = state;
  const props = {
    code,
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
    const { code, language } = this.props;
    if (!code) {
      return <p className="mt-3">{t('user_code_instructions')}</p>;
    }

    const mappedLanguage = get(languageMapping, language, language);

    return (
      <div>
        <p className="mt-3 mb-0">{t('user_code')}</p>
        <Highlight languages={[mappedLanguage]}>
          {code}
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
    const { t, solutionState } = props;
    const showButtonClasses = cn({
      'btn btn-primary x-no-focus-outline x-cursor-pointer px-4 mr-3': true,
      disabled: !solutionState.canBeShown,
    });
    return (
      <p>
        {t('solution_notice')}
        <button
          type="button"
          className={showButtonClasses}
          onClick={this.handleShowSolution}
        >
          {t('show_solution')}
        </button>
      </p>
    );
  }

  renderContent = (props) => ({ total }) => {
    const { solutionState, t } = props;
    if (solutionState.shown) {
      return this.renderSolution(props);
    }
    if (solutionState.canBeShown) {
      return this.renderShowButton(props);
    }

    return <p>{t('solution_instructions', { remainingTime: total })}</p>;
  }

  render() {
    const {
      startTime,
    } = this.props;

    return (
      <div className="p-3 pt-2 d-flex flex-column flex-fill">
        <Countdown date={startTime + 1200} renderer={this.renderContent(this.props)} />
      </div>
    );
  }
}

export default Solution;
