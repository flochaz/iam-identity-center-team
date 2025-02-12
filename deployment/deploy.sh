# Copyright 2022 Amazon Web Services, Inc
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/usr/bin/env bash
set -xe

. "./parameters.sh"

if [ -z "$TEAM_ACCOUNT" ]; then 
  export AWS_PROFILE=$ORG_MASTER_PROFILE
else 
  export AWS_PROFILE=$TEAM_ACCOUNT_PROFILE
fi

cd ..
cd ./deployment

aws cloudformation deploy --region $REGION --template-file template.yml \
  --stack-name TEAM-IDC-APP \
  --parameter-overrides \
    Login=$IDC_LOGIN_URL \
    CloudTrailAuditLogs=$CLOUDTRAIL_AUDIT_LOGS \
    teamAdminGroup="$TEAM_ADMIN_GROUP" \
    teamAuditGroup="$TEAM_AUDITOR_GROUP" \
    tags="$TAGS" \
    teamAccount="$TEAM_ACCOUNT" \
    customAmplifyDomain="$UI_DOMAIN" \
    customRepository="Yes" \
    customRepositorySecretName="$SECRET_NAME" \
  --tags $TAGS \
  --no-fail-on-empty-changeset --capabilities CAPABILITY_NAMED_IAM