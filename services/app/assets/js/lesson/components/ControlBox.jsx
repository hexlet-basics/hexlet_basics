import React from 'react';
import cn from 'classnames';

export default class TabsBox extends React.Component {
  handleRunCheck = () => {
    const { code } = this.props;
    this.props.runCheck({ code });
  }

  render() {
    const { checkInfo } = this.props;

    const buttonClasses = cn({
      'btn btn-primary': true,
      disabled: checkInfo.processing,
    });

    return (
      <div className="row">
        <div className="col">
          <button className={buttonClasses} onClick={this.handleRunCheck}>Run</button>
        </div>
      </div>
    );
  }
}
