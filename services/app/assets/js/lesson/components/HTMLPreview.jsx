// @ts-check

import React from 'react';

// import {
//   TabContent, TabPane, Nav, NavItem, NavLink,
// } from 'reactstrap';

const HTMLPreview = (props) => {
  const { html } = props;
  return (
    <div className="mt-2 p-2 h-md-50 overflow-auto bg-light">
      <pre>
        <code className="nohighlight x-wrap-word">
          <div dangerouslySetInnerHTML={{ __html: html }} />
        </code>
      </pre>
    </div>
  );
};

export default HTMLPreview;
