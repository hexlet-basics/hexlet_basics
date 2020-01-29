// @ts-check

import MarkdownIt from 'markdown-it';
import hljs from 'highlight.js';

const md = new MarkdownIt({
  highlight: (str, lang) => {
    if (lang && hljs.getLanguage(lang)) {
      try {
        const text = hljs.highlight(lang, str).value;
        return `<pre class="hljs"><code>${text}</code></pre>`;
      } catch (__) {
        return hljs.highlightAuto(str);
      }
    }

    return '';
  },
});

export default text => md.render(text);
