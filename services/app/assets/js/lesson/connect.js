import { connect } from 'react-redux';
import * as actionCreators from './actions';

export default mapStateToProps => Component => connect(mapStateToProps, actionCreators)(Component);
