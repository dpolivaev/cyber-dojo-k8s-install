#!/bin/bash -Eeu

# Normally I export the cyberdojo env-vars using the command
# $ docker run --rm cyberdojo/versioner:latest
# This won't work on the.circleci deployment step since it is
# run inside the cyberdojo/gcloud-kubectl-helm image which does
# not have docker. So doing it directly from versioner's git repo


# initialize
readonly GITHUB_RAW_CONTENT=https://raw.githubusercontent.com
readonly GITHUB_ORGANIZATION=cyber-dojo
export $(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/versioner/master/app/.env)
readonly TMP_VALUES_YML=$(mktemp /tmp/values.yml.tmp.XXXXXXXXXX)
readonly TMP_STAGE_SPECIFIC_VALUES_YML=$(mktemp /tmp/ingress.yml.tmp.XXXXXXXXXX)
readonly HELM_REPO=./helm-charts
readonly NAMESPACE=default

# CUSTOM_START_POINTS
REPO=custom-start-points
IMAGE="${CYBER_DOJO_CUSTOM_START_POINTS_IMAGE}"
PORT="${CYBER_DOJO_CUSTOM_START_POINTS_PORT}"
TAG="${CYBER_DOJO_CUSTOM_START_POINTS_TAG}"
SHA="${CYBER_DOJO_CUSTOM_START_POINTS_SHA}"
REPO_VALUES_YML=custom-start-point-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${CYBER_DOJO_CUSTOM_START_POINTS_IMAGE} \
  --set-string containers[0].tag=${CYBER_DOJO_CUSTOM_START_POINTS_TAG} \
  --set service.port=${CYBER_DOJO_CUSTOM_START_POINTS_PORT} \
  --set containers[0].livenessProbe.port=${CYBER_DOJO_CUSTOM_START_POINTS_PORT} \
  --set containers[0].readinessProbe.port=${CYBER_DOJO_CUSTOM_START_POINTS_PORT} \
  --set-string service.annotations."prometheus\.io/port"=${CYBER_DOJO_CUSTOM_START_POINTS_PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# LANGUAGES_START_POINTS
REPO=languages-start-points
IMAGE=cyberdojo/languages-start-points-all  # special value
PORT="${CYBER_DOJO_LANGUAGES_START_POINTS_PORT}"
TAG="${CYBER_DOJO_LANGUAGES_START_POINTS_TAG}"
SHA="${CYBER_DOJO_LANGUAGES_START_POINTS_SHA}"
REPO_VALUES_YML=languages-start-points-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# EXERCISES_START_POINTS
REPO=exercises-start-points
IMAGE="${CYBER_DOJO_EXERCISES_START_POINTS_IMAGE}"
PORT="${CYBER_DOJO_EXERCISES_START_POINTS_PORT}"
TAG="${CYBER_DOJO_EXERCISES_START_POINTS_TAG}"
SHA="${CYBER_DOJO_EXERCISES_START_POINTS_SHA}"
REPO_VALUES_YML=exercises-start-points-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# CREATOR
REPO=creator
IMAGE="${CYBER_DOJO_CREATOR_IMAGE}"
PORT="${CYBER_DOJO_CREATOR_PORT}"
TAG="${CYBER_DOJO_CREATOR_TAG}"
SHA="${CYBER_DOJO_CREATOR_SHA}"
REPO_VALUES_YML=creator-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# CUSTOM_CHOOSER
REPO=custom-chooser
IMAGE="${CYBER_DOJO_CUSTOM_CHOOSER_IMAGE}"
PORT="${CYBER_DOJO_CUSTOM_CHOOSER_PORT}"
TAG="${CYBER_DOJO_CUSTOM_CHOOSER_TAG}"
SHA="${CYBER_DOJO_CUSTOM_CHOOSER_SHA}"
REPO_VALUES_YML=custom-chooser-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# EXERCISES_CHOOSER
REPO=exercises-chooser
IMAGE="${CYBER_DOJO_EXERCISES_CHOOSER_IMAGE}"
PORT="${CYBER_DOJO_EXERCISES_CHOOSER_PORT}"
TAG="${CYBER_DOJO_EXERCISES_CHOOSER_TAG}"
SHA="${CYBER_DOJO_EXERCISES_CHOOSER_SHA}"
REPO_VALUES_YML=exercises-chooser-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# LANGUAGES_CHOOSER
REPO=languages-chooser
IMAGE="${CYBER_DOJO_LANGUAGES_CHOOSER_IMAGE}"
PORT="${CYBER_DOJO_LANGUAGES_CHOOSER_PORT}"
TAG="${CYBER_DOJO_LANGUAGES_CHOOSER_TAG}"
SHA="${CYBER_DOJO_LANGUAGES_CHOOSER_SHA}"
REPO_VALUES_YML=languages-chooser-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# AVATARS
REPO=avatars
IMAGE="${CYBER_DOJO_AVATARS_IMAGE}"
PORT="${CYBER_DOJO_AVATARS_PORT}"
TAG="${CYBER_DOJO_AVATARS_TAG}"
SHA="${CYBER_DOJO_AVATARS_SHA}"
REPO_VALUES_YML=avatars-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# DIFFER
REPO=differ
IMAGE="${CYBER_DOJO_DIFFER_IMAGE}"
PORT="${CYBER_DOJO_DIFFER_PORT}"
TAG="${CYBER_DOJO_DIFFER_TAG}"
SHA="${CYBER_DOJO_DIFFER_SHA}"
REPO_VALUES_YML=differ-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# RUNNER
REPO=runner
IMAGE="${CYBER_DOJO_RUNNER_IMAGE}"
PORT="${CYBER_DOJO_RUNNER_PORT}"
TAG="${CYBER_DOJO_RUNNER_TAG}"
SHA="${CYBER_DOJO_RUNNER_SHA}"
REPO_VALUES_YML=runner-values.yml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# SAVER
REPO=saver
IMAGE="${CYBER_DOJO_SAVER_IMAGE}"
PORT="${CYBER_DOJO_SAVER_PORT}"
TAG="${CYBER_DOJO_SAVER_TAG}"
SHA="${CYBER_DOJO_SAVER_SHA}"
REPO_VALUES_YML=saver-values.yml
REPO_STAGE_SPECIFIC_VALUES_YML=saver-pvc-prod.yml

# curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}
curl ${GITHUB_RAW_CONTENT}/dpolivaev/${REPO}/master/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_STAGE_SPECIFIC_VALUES_YML} \
  > ${TMP_STAGE_SPECIFIC_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].tag=${TAG} \
  --values ${TMP_VALUES_YML} \
  --values ${TMP_STAGE_SPECIFIC_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# REPLER
REPO=repler
IMAGE="${CYBER_DOJO_REPLER_IMAGE}"
PORT="${CYBER_DOJO_REPLER_PORT}"
TAG="${CYBER_DOJO_REPLER_TAG}"
SHA="${CYBER_DOJO_REPLER_SHA}"
REPO_VALUES_YML=repler-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}


# SHAS

REPO=shas
IMAGE="${CYBER_DOJO_SHAS_IMAGE}"
PORT="${CYBER_DOJO_SHAS_PORT}"
TAG="${CYBER_DOJO_SHAS_TAG}"
SHA="${CYBER_DOJO_SHAS_SHA}"
REPO_VALUES_YML=shas-values.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].image=${IMAGE} \
  --set-string containers[0].tag=${TAG} \
  --set service.port=${PORT} \
  --set containers[0].livenessProbe.port=${PORT} \
  --set containers[0].readinessProbe.port=${PORT} \
  --set-string service.annotations."prometheus\.io/port"=${PORT} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# WEB
REPO=web
IMAGE="${CYBER_DOJO_WEB_IMAGE}"
PORT="${CYBER_DOJO_WEB_PORT}"
TAG="${CYBER_DOJO_WEB_TAG}"
SHA="${CYBER_DOJO_WEB_SHA}"
REPO_VALUES_YML=web-values.yml

# curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}
curl ${GITHUB_RAW_CONTENT}/dpolivaev/${REPO}/master/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

helm upgrade \
  --install \
  --namespace=${NAMESPACE} \
  --set-string containers[0].tag=${TAG} \
  --values ${TMP_VALUES_YML} \
  ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# NGINX
REPO=nginx
IMAGE="${CYBER_DOJO_NGINX_IMAGE}"
PORT="${CYBER_DOJO_NGINX_PORT}"
TAG="${CYBER_DOJO_NGINX_TAG}"
SHA="${CYBER_DOJO_NGINX_SHA}"
REPO_VALUES_YML=nginx-values.yaml
REPO_STAGE_SPECIFIC_VALUES_YML=nginx-ingress-prod.yaml

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_STAGE_SPECIFIC_VALUES_YML} \
  > ${TMP_STAGE_SPECIFIC_VALUES_YML}

helm upgrade \
  --install \
  --namespace="${NAMESPACE}" \
  --set-string containers[0].tag=${TAG} \
  --values ${TMP_VALUES_YML} \
  --values ${TMP_STAGE_SPECIFIC_VALUES_YML} \
 ${NAMESPACE}-${REPO} \
  ${HELM_REPO}

# clean
rm ${TMP_VALUES_YML}
rm ${TMP_STAGE_SPECIFIC_VALUES_YML}
