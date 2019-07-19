// @ts-check

import React from 'react';
import MonacoEditor from 'react-monaco-editor';
import { get } from 'lodash';
// import { registerRulesForLanguage } from 'monaco-ace-tokenizer';


export const languageMapping = {
  racket: 'scheme',
};

const langToTabSizeMapping = {
  javascript: 2,
  ruby: 2,
  yml: 2,
  py: 2,
  rkt: 2,
  erlang: 2,
};

const defaultTabSize = 4;

export default class Editor extends React.Component {
  componentDidUpdate() {
    const { current } = this.props;
    if (this.editor && current) {
      this.editor.focus();
    }
  }

  // loadHightLightForNotIncludeSyntax = async (syntax) => {
  //   const { default: HighlightRules } = await import(`monaco-ace-tokenizer/lib/ace/definitions/${syntax}`);
  //   this.monaco.languages.register({
  //     id: syntax,
  //   });
  //   registerRulesForLanguage(syntax, new HighlightRules());
  // }


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
    this.editor.getModel().updateOptions({ tabSize: get(langToTabSizeMapping, language, defaultTabSize)});
    // this.editor.getModel().updateOptions({ tabSize: this.tabSize });
    // if (language === 'racket') {
    //   this.loadHightLightForNotIncludeSyntax(language);
    // }
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
        theme="vs-dark"
        options={options}
        language={get(languageMapping, language, language)}
        editorDidMount={this.editorDidMount}
        defaultValue={defaultValue}
        onChange={this.handleChange}
      />
    );
  }
}
