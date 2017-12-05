import React from 'react';
import ansiUp from '../../lib/ansi_up';

export default ({ outputs }) => {
  const html = outputs.map(ansiUp).join('\n\n');
  return (<div>
    <pre>
      <code>
        {html}
      </code>
    </pre>
  </div>);
};
