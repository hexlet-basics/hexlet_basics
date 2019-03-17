import { get } from 'lodash';
import React from 'react';
import MonacoEditor from 'react-monaco-editor';

const languageMapping = {
  racket: 'scheme',
};

export default class Editor extends React.Component {
  componentDidUpdate() {
    if (this.editor && this.props.current) {
      this.editor.focus();
    }
  }

  handleResize = () => this.editor.layout();

  handleChange = content => this.props.onCodeChange({ content });

  editorDidMount = (editor) => {
    this.editor = editor;
    this.editor.focus();
    // this.editor.getModel().updateOptions({ tabSize: this.tabSize });

    window.addEventListener('resize', this.handleResize);
  }

  render() {
    const options = {
      fontSize: 16,
      scrollBeyondLastLine: false,
      selectOnLineNumbers: true,
      // automaticLayout: true,
      minimap: {
        enabled: false,
      },
    };

    const { language, defaultValue } = this.props;
    const monacoLanguage = get(languageMapping, language, language);
    // console.log(languageMapping, language, monacoLanguage)
    return (
      <MonacoEditor
        theme="vs-dark"
        options={options}
        language={monacoLanguage}
        editorDidMount={this.editorDidMount}
        defaultValue={defaultValue}
        onChange={this.handleChange}
      />
    );
  }
}
