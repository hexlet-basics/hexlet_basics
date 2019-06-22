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
    <pre className="p-3 mb-0 h-100 bg-black text-white">
      <code className="nohighlight x-wrap-word">
        <div dangerouslySetInnerHTML={{ __html: html }} />
      </code>
    </pre>
  );
};

export default Console;
