import React from 'react';
import { MonacoDiffEditor } from 'react-monaco-editor';
import connect from '../connect';

const mapStateToProps = (state) => {
  const { code, finished } = state;
  const props = { code, finished };
  return props;
};

@connect(mapStateToProps)
export default class Editor extends React.Component {
  render() {
    const {
      code, userFinishedLesson, finished, defaultValue, language,
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

    const renderSolution = (
      <MonacoDiffEditor
        theme="vs-dark"
        original={teacherCode}
        value={userCode}
        options={options}
        language={language}
      />
    );

    const renderMessage = <p>Решение учителя станет доступно после успешного выполнения задачи</p>;

    return finished || userFinishedLesson ? renderSolution : renderMessage;
  }
}
