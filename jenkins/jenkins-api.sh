#!/bin/bash
# Helper to call the local Jenkins REST API: ./jenkins-api.sh METHOD PATH [curl args...]
set -e
cd "$(dirname "$0")"
source .env
J=http://localhost:8090
AUTH="kim_vladislav:$JENKINS_ADMIN_PASSWORD"
JAR=$(mktemp)
CRUMB=$(curl -s -c "$JAR" -u "$AUTH" "$J/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)")
METHOD=$1; P=$2; shift 2
curl -s -b "$JAR" -u "$AUTH" -H "$CRUMB" -X "$METHOD" "$J$P" "$@"
rm -f "$JAR"
