import React from 'react';
import ansiUp from '../../lib/ansi_up';

export default ({ output, className }) => {
  const html = ansiUp(output);
  return (<div className={className}>
    <pre>
      <code className="x-wrap-word">
        {html}
      </code>
    </pre>
  </div>);
};
