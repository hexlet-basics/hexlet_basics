import React from 'react';
import sanitizeHtml from 'sanitize-html';
import ansiUp from '../../lib/ansi_up';

const Console = ({ output, className }) => {
  const html = ansiUp(sanitizeHtml(output));
  return (
    <div className={className}>
      <pre>
        <code className="x-wrap-word">
          <div dangerouslySetInnerHTML={html} />
        </code>
      </pre>
    </div>
  );
};

export default Console;
