import React from 'react';
import MonacoEditor from 'react-monaco-editor';

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
    return (<MonacoEditor
      theme="vs-dark"
      options={options}
      language={this.props.language}
      editorDidMount={this.editorDidMount}
      value={this.props.defaultValue}
      onChange={this.handleChange}
    />);
  }
}

