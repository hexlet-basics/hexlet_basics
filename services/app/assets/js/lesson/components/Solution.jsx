import React from 'react';
import { MonacoDiffEditor } from 'react-monaco-editor';
import connect from '../connect';

const mapStateToProps = (state) => {
  const { code, finished, checkInfo } = state;
  const props = { code, finished, checkInfo };
  return props;
};

@connect(mapStateToProps)
export default class Editor extends React.Component {
  editorDidMount = (editor) => {
    this.editor = editor;
    this.editor.focus();
    // this.editor.getModel().updateOptions({ tabSize: this.tabSize });

    window.addEventListener('resize', this.handleResize);
  };

  componentDidUpdate() {
    if (this.editor && this.props.current) {
      this.editor.focus();
    }
  }

  handleResize = () => this.editor.layout();
  handleChange = content => this.props.onCodeChange({ content });

  render() {
    const { code, userFinishedLesson, finished } = this.props;

    const requireConfig = {
      url: 'https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.5/require.min.js',
      paths: {
        vs: 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.10.1/min/vs/',
      },
    };

    const userCode = code;
    const teacherCode = '// a different version...';
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
        original={userCode}
        value={teacherCode}
        options={options}
        language={this.props.language}
        editorDidMount={this.editorDidMount}
        defaultValue={this.props.defaultValue}
        requireConfig={requireConfig}
        onChange={this.handleChange}
      />
    );

    const renderMessage = <p>Решение учителя станет доступно после успешного выполнения задачи</p>;

    return finished || userFinishedLesson ? renderSolution : renderMessage;
  }
}
