import React from 'react';
import Editor from './Editor.jsx';
import JQConsole from '../../lib/components/JQConsole.jsx';
import md from '../../lib/markdown';

export default class App extends React.Component {
  render() {
    const { lesson, language } = this.props;
    const theory = md(lesson.theory);
    console.log(lesson.instructions);
    const instructions = md(lesson.instructions);

    return (<div className="row">
      <div className="col-4">
        <div className="card">
          <div className="card-header">
            {lesson.name}
          </div>
          <div className="card-body">
            <h5 className="card-title">Теория</h5>
            <div className="card-text" dangerouslySetInnerHTML={{ __html: theory }} />
            <h5 className="card-title">Инструкции</h5>
            <div className="card-text" dangerouslySetInnerHTML={{ __html: instructions }} />
          </div>
        </div>
      </div>
      <div className="col-4 no-gutters pl-0 pr-0">
        <Editor border-dark defaultValue={lesson.prepared_code} language={language.slug} />
        <div className="m-1">
          <button className="btn btn-primary">Run</button>
        </div>
      </div>
      <div className="col-4 border border-dark">
        <JQConsole />
      </div>
    </div>);
  }
}
