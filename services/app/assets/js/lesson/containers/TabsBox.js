import { connect } from 'react-redux';
import * as actionCreators from '../actions';
import TabsBox from '../components/TabsBox.jsx';

const mapStateToProps = (state) => {
  const { checkInfo, currentTabInfo } = state;
  const props = { checkInfo, currentTabInfo };
  return props;
};

export default connect(
  mapStateToProps,
  actionCreators,
)(TabsBox);

