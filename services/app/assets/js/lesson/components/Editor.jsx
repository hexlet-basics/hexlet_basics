import React from 'react';
import MonacoEditor from 'react-monaco-editor';

export default class App extends React.Component {
  editorDidMount = (editor) => {
    this.editor = editor;
    this.editor.focus();
    // this.editor.getModel().updateOptions({ tabSize: this.tabSize });

    window.addEventListener('resize', this.handleResize);
  }

  componentDidUpdate() {
    if (this.editor) {
      this.editor.focus();
    }
  }

  handleResize = () => this.editor.layout();
  handleChange = content => this.props.changeCode({ content });

  render() {
    const requireConfig = {
      url: 'https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.5/require.min.js',
      paths: {
        vs: 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.10.1/min/vs/',
      },
    };

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
      defaultValue={this.props.defaultValue}
      requireConfig={requireConfig}
      onChange={this.handleChange}
    />);
  }
}

