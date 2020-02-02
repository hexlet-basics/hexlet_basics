// @ts-check

import { connect } from 'react-redux';
import { actions } from './slices';

export default () => (Component) => connect(null, { ...actions })(Component);
