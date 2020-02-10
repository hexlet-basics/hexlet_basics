// @ts-check

import React from 'react';
import cn from 'classnames';
import { useTranslation } from 'react-i18next';
import ansiUp from '../../lib/ansi_up';

const Console = ({ checkInfo }) => {
  const html = ansiUp(checkInfo.output);
  const { t } = useTranslation();

  const message = checkInfo.result ? t(`check.${checkInfo.result}.message`) : null;
  const alertClassName = cn('mt-auto text-center alert', {
    'alert-success': checkInfo.passed,
    'alert-warning': !checkInfo.passed,
  });
  return (
    <div className="d-flex flex-column h-100">
      <pre>
        <code className="nohighlight" dangerouslySetInnerHTML={{ __html: html }} />
      </pre>
      {message && <div className={alertClassName}>{message}</div>}
    </div>
  );
};

export default Console;
