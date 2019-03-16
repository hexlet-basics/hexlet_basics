import React from 'react';
import cn from 'classnames';
import { Highlight } from 'react-fast-highlight';
import { withTranslation } from 'react-i18next';
import dateFns from 'date-fns';
import dateFnsLocale from '../../lib/data-fns-locale';
import connect from '../connect';

const mapStateToProps = (state) => {
  const {
    code,
    solutionState,
    countdown,
  } = state;
  const props = {
    code,
    solutionState,
    countdown,
  };
  return props;
};

@connect(mapStateToProps)
@withTranslation()
class Editor extends React.Component {
  handleShowSolution = () => {
    const { showSolution } = this.props;
    showSolution();
  }

  renderUserCode(t) {
    const { code, language } = this.props;
    if (!code) {
      return <p className="mt-3">{t('user_code_instructions')}</p>;
    }
    return (
      <div>
        <p className="mt-3 mb-0">{t('user_code')}</p>
        <Highlight languages={[language]}>
          {code}
        </Highlight>
      </div>
    );
  }

  renderSolution(t) {
    const { language, defaultValue } = this.props;
    return (
      <div className="p-3 pt-2 x-overflow-y-scroll" id="basics-solution">
        <p className="mb-0">{t('teacher_solution')}</p>
        <Highlight languages={[language]}>
          {defaultValue}
        </Highlight>
        {this.renderUserCode(t)}
      </div>
    );
  }

  renderShowButton(t) {
    const { solutionState } = this.props;
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

  renderCountdownTimer(t) {
    const { countdown } = this.props;
    const remainingTime = dateFns.distanceInWordsStrict(
      countdown.currentTime,
      countdown.finishTime,
      { locale: dateFnsLocale },
    );
    return <p>{t('solution_instructions', { remainingTime })}</p>;
  }

  renderMessage(t) {
    const { solutionState } = this.props;
    return (
      <div className="p-3 pt-2" id="basics-solution">
        {solutionState.canBeShown ? this.renderShowButton(t) : this.renderCountdownTimer(t) }
      </div>
    );
  }

  render() {
    const {
      solutionState,
      t,
    } = this.props;

    return solutionState.shown ? this.renderSolution(t) : this.renderMessage(t);
  }
}

export default Editor;
