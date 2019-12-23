// @ts-check

import { connect } from 'react-redux';
import { actions } from './slices';

export default (mapStateToProps = () => ({}), mapDispatch = {}) => (Component) => connect(mapStateToProps, { ...actions, ...mapDispatch })(Component);
