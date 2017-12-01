import React from 'react';
import MonacoEditor from 'react-monaco-editor';

export default class App extends React.Component {
  editorDidMount(editor, monaco) {
    console.log('editorDidMount', editor);
    editor.focus();
  }

  render() {
    const requireConfig = {
      url: 'https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.5/require.min.js',
      paths: {
        'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.10.1/min/vs/'
      }
    };
    return (<div className="row h-100">
      <div className="col-3">
        sidebar
      </div>
      <div className="col-9">
        <MonacoEditor
          language="javascript"
          editorDidMount={this.editorDidMount}
          requireConfig={requireConfig}
        />
      </div>
    </div>);
  }
}
