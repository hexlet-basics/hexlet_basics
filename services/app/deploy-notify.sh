#!/bin/bash
curl https://api.rollbar.com/api/1/deploy/ -F access_token=$ROLLBAR_ACCESS_TOKEN -F environment=$MIX_ENV -F revision=$CODE_BASICS_VERSION -F local_username=code_basics_production

