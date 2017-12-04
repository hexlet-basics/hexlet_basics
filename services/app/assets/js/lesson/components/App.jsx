import React from 'react';
import PropTypes from 'prop-types';
import TabsBox from './TabsBox.jsx';
import md from '../../lib/markdown';

export default class App extends React.Component {
  getChildContext() {
    return {
      language: this.props.language,
      lesson: this.props.lesson,
    };
  }

  render() {
    const { lesson } = this.props;
    const theory = md(lesson.theory);
    const instructions = md(lesson.instructions);

    return (<div className="row">
      <div className="col-5">
        <div className="card hexlet-basics-card">
          <h4 className="card-header">
            {lesson.name}
          </h4>
          <div className="card-body">
            <h5 className="card-title">Теория</h5>
            <div className="card-text" dangerouslySetInnerHTML={{ __html: theory }} />
            <h5 className="card-title">Инструкции</h5>
            <div className="card-text" dangerouslySetInnerHTML={{ __html: instructions }} />
          </div>
        </div>
      </div>
      <div className="col-7 no-gutters pl-0">
        <TabsBox />
        <div className="row">
          <div className="col">
            <button className="btn btn-primary">Run</button>
          </div>
        </div>
      </div>
    </div>);
  }
}

App.childContextTypes = {
  lesson: PropTypes.object,
  language: PropTypes.object,
};
