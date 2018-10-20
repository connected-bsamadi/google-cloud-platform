#! /bin/bash

export CLIENT_ID=<CLIENT_ID from OAuth page>
export CLIENT_SECRET=<CLIENT_SECRET from OAuth page>
export PROJECT=<PROJECT_ID>

export KUBEFLOW_REPO=v0.3.0
export KFAPP=kubeflow

mkdir ${KUBEFLOW_REPO}
cd ${KUBEFLOW_REPO}
export KUBEFLOW_TAG=v0.3.0
curl https://raw.githubusercontent.com/kubeflow/kubeflow/${KUBEFLOW_TAG}/scripts/download.sh | bash

${KUBEFLOW_REPO}/scripts/kfctl.sh init ${KFAPP} --platform gcp --project ${PROJECT}
cd ${KFAPP}
${KUBEFLOW_REPO}/scripts/kfctl.sh generate platform
${KUBEFLOW_REPO}/scripts/kfctl.sh apply platform
${KUBEFLOW_REPO}/scripts/kfctl.sh generate k8s
${KUBEFLOW_REPO}/scripts/kfctl.sh apply k8s

kubectl -n kubeflow get  all

echo "Kubeflow will be available at the following URI:"
echo "https://${KFAPP}.endpoints.${PROJECT}.cloud.goog/"
