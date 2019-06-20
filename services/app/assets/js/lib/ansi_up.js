// @ts-check

import AnsiUp from 'ansi_up';

const obj = new AnsiUp();
export default content => obj.ansi_to_html(content);
