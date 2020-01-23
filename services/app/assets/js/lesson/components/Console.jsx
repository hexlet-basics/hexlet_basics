// @ts-check

import React from 'react';
// import { escape } from 'lodash';
// import sanitizeHtml from 'sanitize-html';
import ansiUp from '../../lib/ansi_up';

const Console = ({ output }) => {
  // const sanitizedOutput = sanitizeHtml(output, {
  //   textFilter: text => text.replace(/&quot;/g, '\''),
  // });
  const html = ansiUp(output);
  return (
    <pre className="h-100">
      <code className="nohighlight" dangerouslySetInnerHTML={{ __html: html }} />
    </pre>
  );
};

export default Console;
