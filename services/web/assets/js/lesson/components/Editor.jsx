// @ts-check

import React from 'react';
import MonacoEditor from 'react-monaco-editor';
import { get } from 'lodash';


export const languageMapping = {
  racket: 'scheme',
  css: 'html',
};

const langToTabSizeMapping = {
  javascript: 2,
  ruby: 2,
  yml: 2,
  py: 2,
  rkt: 2,
  erlang: 2,
  elixir: 2,
};

const defaultTabSize = 4;

export default class Editor extends React.Component {
  componentDidUpdate() {
    const { current } = this.props;
    if (this.editor && current) {
      this.editor.layout();
      this.editor.focus();
    }
  }

  handleResize = () => this.editor.layout();

  handleChange = (content) => {
    const { onCodeChange } = this.props;
    onCodeChange({ content });
  }

  editorDidMount = (editor, monaco) => {
    const { language } = this.props;
    this.editor = editor;
    this.monaco = monaco;
    this.editor.focus();
    const model = this.editor.getModel();
    model.updateOptions({ tabSize: get(langToTabSizeMapping, language, defaultTabSize)});
    window.addEventListener('resize', this.handleResize);
  }

  render() {
    const options = {
      fontSize: 14,
      // scrollBeyondLastLine: false,
      // selectOnLineNumbers: true,
      // automaticLayout: true,
      // minimap: {
      //   enabled: false,
      // },
    };

    const { language, defaultValue } = this.props;

    return (
      <MonacoEditor
        options={options}
        language={get(languageMapping, language, language)}
        editorDidMount={this.editorDidMount}
        defaultValue={defaultValue}
        onChange={this.handleChange}
      />
    );
  }
}
