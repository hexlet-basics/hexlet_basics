import { connect } from 'react-redux';
import * as actionCreators from '../actions';
import ControlBox from '../components/ControlBox.jsx';

const mapStateToProps = (state) => {
  const { checkInfo, code } = state;
  const props = { checkInfo, code };
  return props;
};

export default connect(
  mapStateToProps,
  actionCreators,
)(ControlBox);

