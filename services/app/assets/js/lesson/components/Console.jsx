import React from 'react';
import ansiUp from '../../lib/ansi_up';

export default ({ output }) => {
  const html = ansiUp(output);
  return (<div>
    <pre>
      <code>
        {html}
      </code>
    </pre>
  </div>);
};
