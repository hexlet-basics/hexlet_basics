// @ts-check

import React from 'react';
import Frame from 'react-frame-component';

const HTMLPreview = (props) => {
  const { html } = props;
  return (
    <div className="mt-2 p-2 h-50 overflow-auto bg-light">
      <Frame className="border-0 h-100 w-100">
        <div className="text-black" dangerouslySetInnerHTML={{ __html: html }} />
      </Frame>
    </div>
  );
};

export default HTMLPreview;
