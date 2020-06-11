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
# readonly HELM_REPO=./helm-charts
readonly HELM_REPO="praqma/cyber-dojo-service --version 0.2.5"
readonly NAMESPACE=default

readonly REPO_VALUES_YML=k8s-general-values.yml
readonly REPO_STAGE_SPECIFIC_VALUES_YML=k8s-prod-values.yml
# CUSTOM_START_POINTS
REPO=custom-start-points
SHA="${CYBER_DOJO_CUSTOM_START_POINTS_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "${CYBER_DOJO_CUSTOM_START_POINTS_IMAGE}" "${CYBER_DOJO_CUSTOM_START_POINTS_TAG}" "${CYBER_DOJO_CUSTOM_START_POINTS_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# LANGUAGES_START_POINTS
REPO=languages-start-points
SHA="${CYBER_DOJO_LANGUAGES_START_POINTS_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "cyberdojo/languages-start-points-all" "${CYBER_DOJO_LANGUAGES_START_POINTS_TAG}" "${CYBER_DOJO_LANGUAGES_START_POINTS_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"


# EXERCISES_START_POINTS
REPO=exercises-start-points
SHA="${CYBER_DOJO_EXERCISES_START_POINTS_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "${CYBER_DOJO_EXERCISES_START_POINTS_IMAGE}" "${CYBER_DOJO_EXERCISES_START_POINTS_TAG}" "${CYBER_DOJO_EXERCISES_START_POINTS_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# CREATOR
REPO=creator
SHA="${CYBER_DOJO_CREATOR_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "${CYBER_DOJO_CREATOR_IMAGE}" "${CYBER_DOJO_CREATOR_TAG}" "${CYBER_DOJO_CREATOR_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# CUSTOM_CHOOSER
REPO=custom-chooser
SHA="${CYBER_DOJO_CUSTOM_CHOOSER_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "${CYBER_DOJO_CUSTOM_CHOOSER_IMAGE}" "${CYBER_DOJO_CUSTOM_CHOOSER_TAG}" "${CYBER_DOJO_CUSTOM_CHOOSER_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"


# EXERCISES_CHOOSER
REPO=exercises-chooser
SHA="${CYBER_DOJO_EXERCISES_CHOOSER_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "${CYBER_DOJO_EXERCISES_CHOOSER_IMAGE}" "${CYBER_DOJO_EXERCISES_CHOOSER_TAG}" "${CYBER_DOJO_EXERCISES_CHOOSER_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# LANGUAGES_CHOOSER
REPO=languages-chooser
SHA="${CYBER_DOJO_LANGUAGES_CHOOSER_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "${CYBER_DOJO_LANGUAGES_CHOOSER_IMAGE}" "${CYBER_DOJO_LANGUAGES_CHOOSER_TAG}" "${CYBER_DOJO_LANGUAGES_CHOOSER_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# AVATARS
REPO=avatars
SHA="${CYBER_DOJO_AVATARS_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade \
   "${NAMESPACE}" \
   "${CYBER_DOJO_AVATARS_IMAGE}" "${CYBER_DOJO_AVATARS_TAG}" "${CYBER_DOJO_AVATARS_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# DIFFER
REPO=differ
SHA="${CYBER_DOJO_DIFFER_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade "${NAMESPACE}" \
   "${CYBER_DOJO_DIFFER_IMAGE}" "${CYBER_DOJO_DIFFER_TAG}" "${CYBER_DOJO_DIFFER_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# RUNNER
REPO=runner
SHA="${CYBER_DOJO_RUNNER_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade "${NAMESPACE}" \
   "${CYBER_DOJO_RUNNER_IMAGE}" "${CYBER_DOJO_RUNNER_TAG}" "${CYBER_DOJO_RUNNER_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"

# SAVER
REPO=saver
SHA="${CYBER_DOJO_SAVER_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_STAGE_SPECIFIC_VALUES_YML} \
  > ${TMP_STAGE_SPECIFIC_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade "${NAMESPACE}" \
   "${CYBER_DOJO_SAVER_IMAGE}" "${CYBER_DOJO_SAVER_TAG}" "${CYBER_DOJO_SAVER_PORT}" \
   "${TMP_VALUES_YML}" "${TMP_STAGE_SPECIFIC_VALUES_YML}" \
   "${REPO}" "${HELM_REPO}"

# REPLER
REPO=repler
SHA="${CYBER_DOJO_REPLER_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade "${NAMESPACE}" \
   "${CYBER_DOJO_REPLER_IMAGE}" "${CYBER_DOJO_REPLER_TAG}" "${CYBER_DOJO_REPLER_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"


# SHAS

REPO=shas
SHA="${CYBER_DOJO_SHAS_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade "${NAMESPACE}" \
   "${CYBER_DOJO_SHAS_IMAGE}" "${CYBER_DOJO_SHAS_TAG}" "${CYBER_DOJO_SHAS_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"


# WEB
REPO=web
SHA="${CYBER_DOJO_WEB_SHA}"

#curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
# > ${TMP_VALUES_YML}

curl ${GITHUB_RAW_CONTENT}/dpolivaev/${REPO}/master/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade "${NAMESPACE}" \
   "${CYBER_DOJO_WEB_IMAGE}" "${CYBER_DOJO_WEB_TAG}" "${CYBER_DOJO_WEB_PORT}" \
   "${TMP_VALUES_YML}" "./k8s-empty-values.yml" \
   "${REPO}" "${HELM_REPO}"


# NGINX
REPO=nginx
SHA="${CYBER_DOJO_NGINX_SHA}"

curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/${REPO_VALUES_YML} \
  > ${TMP_VALUES_YML}

source <(curl ${GITHUB_RAW_CONTENT}/${GITHUB_ORGANIZATION}/${REPO}/${SHA}/.circleci/helm_upgrade.sh)

helm_upgrade "${NAMESPACE}" \
   "${CYBER_DOJO_NGINX_IMAGE}" "${CYBER_DOJO_NGINX_TAG}" "${CYBER_DOJO_NGINX_PORT}" \
   "${TMP_VALUES_YML}" "./nginx-ingress.yaml" \
   "${REPO}" "${HELM_REPO}"

# clean
rm ${TMP_VALUES_YML}
rm ${TMP_STAGE_SPECIFIC_VALUES_YML}
