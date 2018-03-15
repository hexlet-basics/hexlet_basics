import React from 'react';
import cn from 'classnames';
import { Highlight } from 'react-fast-highlight';
import { translate } from 'react-i18next';
import connect from '../connect';

const mapStateToProps = (state) => {
  const {
    code,
    solution: { lessonFinished, userWantsToSeeSolution },
    countdown: { remainingTime, canShowSolution },
  } = state;
  const props = {
    code,
    lessonFinished,
    userWantsToSeeSolution,
    remainingTime,
    canShowSolution,
  };
  return props;
};

@connect(mapStateToProps)
@translate()
export default class Editor extends React.Component {
  handleShowSolution = () => {
    this.props.setUserWantsToSeeSolution();
  }

  render() {
    const {
      code,
      lessonFinished,
      userWantsToSeeSolution,
      remainingTime,
      canShowSolution,
      userFinishedLesson,
      defaultValue,
      language,
      t,
    } = this.props;

    const d = new Date(remainingTime);
    const minutes = d.getUTCMinutes();
    const seconds = d.getUTCSeconds();

    const teacherCode = defaultValue;
    const userCode = code;

    const renderUserCode = userCode ? (
      <div>
        <p className="mt-3 mb-0">{t('user_code')}</p>
        <Highlight languages={[language]}>
          {userCode}
        </Highlight>
      </div>
    ) : (<p className="mt-3">{t('user_code_instructions')}</p>);

    const renderSolution = (
      <div className="p-3 pt-2" id="basics-solution">
        <p className="mb-0">{t('teacher_solution')}</p>
        <Highlight languages={[language]}>
          {teacherCode}
        </Highlight>
        {renderUserCode}
      </div>
    );

    const showButtonClasses = cn({
      'btn btn-primary x-no-focus-outline x-cursor-pointer px-4 mr-3': true,
      disabled: !canShowSolution,
    });

    const renderShowButton = (
      <p>
        {t('solution_notice')}
        <button className={showButtonClasses} onClick={this.handleShowSolution}>{t('show_solution')}</button>
      </p>
    );

    const renderCountdownTimer = (
      <p>{t('solution_instructions', { minutes: t('minutes', { count: minutes }), seconds: t('seconds', { count: seconds }) })}</p>
    );

    const renderMessage = (
      <div className="p-3 pt-2" id="basics-solution">
        {canShowSolution ? renderShowButton : renderCountdownTimer}
      </div>
    );

    return lessonFinished || userFinishedLesson || userWantsToSeeSolution ? renderSolution : renderMessage;
  }
}
