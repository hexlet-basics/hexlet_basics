// @ts-check

import React from 'react';

const HTMLPreview = (props) => {
  const { html } = props;
  return (
    <div className="mt-2 p-2 h-50 overflow-auto bg-light">
        <div dangerouslySetInnerHTML={{ __html: html }} />
    </div>
  );
};

export default HTMLPreview;
