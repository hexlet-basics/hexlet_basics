// @ts-check

import React from 'react';
// import { escape } from 'lodash';
// import sanitizeHtml from 'sanitize-html';
import ansiUp from '../../lib/ansi_up';

const Console = ({ output, className }) => {
  // const sanitizedOutput = sanitizeHtml(output, {
  //   textFilter: text => text.replace(/&quot;/g, '\''),
  // });
  const html = ansiUp(output);
  return (
    <div className={className}>
      <pre>
        <code className="nohighlight x-wrap-word">
          <div dangerouslySetInnerHTML={{ __html: html }} />
        </code>
      </pre>
    </div>
  );
};

export default Console;
