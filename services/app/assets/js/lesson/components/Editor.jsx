import React from 'react';
import MonacoEditor from 'react-monaco-editor';
import { registerRulesForLanguage } from 'monaco-ace-tokenizer';


export const languageMapping = {
  racket: 'scheme',
};

export default class Editor extends React.Component {
  componentDidUpdate() {
    const { current } = this.props;
    if (this.editor && current) {
      this.editor.focus();
    }
  }

  loadHightLightForNotIncludeSyntax = async (syntax) => {
    const { default: HighlightRules } = await import(`monaco-ace-tokenizer/lib/ace/definitions/${syntax}`);
    this.monaco.languages.register({
      id: syntax,
    });
    registerRulesForLanguage(syntax, new HighlightRules());
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
    // this.editor.getModel().updateOptions({ tabSize: this.tabSize });
    if (language === 'racket') {
      this.loadHightLightForNotIncludeSyntax(language);
    }
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

    return (
      <MonacoEditor
        theme="vs-dark"
        options={options}
        language={language}
        editorDidMount={this.editorDidMount}
        defaultValue={defaultValue}
        onChange={this.handleChange}
      />
    );
  }
}
