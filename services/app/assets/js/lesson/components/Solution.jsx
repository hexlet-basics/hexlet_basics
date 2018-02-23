import React from 'react';
import { Highlight } from 'react-fast-highlight';
import { translate } from 'react-i18next';
import connect from '../connect';

const mapStateToProps = (state) => {
  const { code, finished } = state;
  const props = { code, finished };
  return props;
};

@connect(mapStateToProps)
@translate()
export default class Editor extends React.Component {
  render() {
    const {
      code, userFinishedLesson, finished, defaultValue, language, t
    } = this.props;

    const teacherCode = defaultValue;
    const userCode = code;
    const options = {
      fontSize: 16,
      scrollBeyondLastLine: false,
      selectOnLineNumbers: true,
      readOnly: true,
      minimap: {
        enabled: false,
      },
    };

    const renderUserCode = userCode ? (
      <div>
        <p className="mt-3 mb-0">{t('user_code')}</p>
        <Highlight languages={[language]}>
          {userCode}
        </Highlight>
      </div>
    ) : (<p className="mt-3">{t('user_code_instructions')}</p>);

    const renderSolution = (
      <div className='p-3 pt-2' id='basics-solution'>
        <p className="mb-0">{t('teacher_solution')}</p>
        <Highlight languages={[language]}>
          {teacherCode}
        </Highlight>
        {renderUserCode}
      </div>
    );

    const renderMessage = <div className='p-3 pt-2' id='basics-solution'><p>{t('solution_instructions')}</p></div>;

    return finished || userFinishedLesson ? renderSolution : renderMessage;
  }
}
