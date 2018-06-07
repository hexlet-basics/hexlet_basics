import React from 'react';
import cn from 'classnames';
import { Highlight } from 'react-fast-highlight';
import { translate } from 'react-i18next';
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
@translate()
export default class Editor extends React.Component {
  handleShowSolution = () => {
    this.props.showSolution();
  }

  renderUserCode() {
    const { code, t } = this.props;
    if (!code) {
      return <p className="mt-3">{t('user_code_instructions')}</p>;
    }
    return (
      <div>
        <p className="mt-3 mb-0">{t('user_code')}</p>
        <Highlight languages={[this.props.language]}>
          {code}
        </Highlight>
      </div>
    );
  }

  renderSolution() {
    const { t } = this.props;
    return (
      <div className="p-3 pt-2 x-overflow-y-scroll" id="basics-solution">
        <p className="mb-0">{t('teacher_solution')}</p>
        <Highlight languages={[this.props.language]}>
          {this.props.defaultValue}
        </Highlight>
        {this.renderUserCode()}
      </div>
    );
  }

  renderShowButton() {
    const { solutionState, t } = this.props;
    const showButtonClasses = cn({
      'btn btn-primary x-no-focus-outline x-cursor-pointer px-4 mr-3': true,
      disabled: !solutionState.canBeShown,
    });
    return (
      <p>
        {t('solution_notice')}
        <button className={showButtonClasses} onClick={this.handleShowSolution}>{t('show_solution')}</button>
      </p>
    );
  }

  renderCountdownTimer() {
    const { countdown, t } = this.props;
    const remainingTime = dateFns.distanceInWordsStrict(
      countdown.currentTime,
      countdown.finishTime,
      { locale: dateFnsLocale },
    );
    return <p>{t('solution_instructions', { remainingTime })}</p>;
  }

  renderMessage() {
    const { solutionState } = this.props;
    return (
      <div className="p-3 pt-2" id="basics-solution">
        {solutionState.canBeShown ? this.renderShowButton() : this.renderCountdownTimer() }
      </div>
    );
  }

  render() {
    const {
      solutionState,
    } = this.props;

    return solutionState.shown ? this.renderSolution() : this.renderMessage();
  }
}
