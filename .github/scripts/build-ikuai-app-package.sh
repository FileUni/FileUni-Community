#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 6 ]; then
  printf 'Usage: %s <repo-root> <output-dir> <version> <target> <binary-path> <artifact-base>\n' "$0" >&2
  exit 1
fi

repo_root="$1"
output_dir="$2"
version="$3"
target="$4"
binary_path="$5"
artifact_base="$6"

template_root="${repo_root}/.github/ikuai/fileuni-cli"
dockerfile_path="${repo_root}/.github/docker/ikuai-app.Dockerfile"
stage_root="$(mktemp -d)"
package_name="fileuni-cli"
package_root="${stage_root}/${package_name}"
docker_context="${stage_root}/docker-context"

cleanup() {
  rm -rf "${stage_root}"
}

trap cleanup EXIT

if [ ! -f "${binary_path}" ]; then
  printf 'Binary not found: %s\n' "${binary_path}" >&2
  exit 1
fi

source "${repo_root}/.github/scripts/arch-helpers.sh"

docker_platform="$(fileuni_docker_platform "${target}")"
manifest_version="$(printf '%s' "${version}" | sed -E 's/^([0-9]+\.[0-9]+\.[0-9]+).*/\1/')"

if [ -z "${manifest_version}" ]; then
  printf 'Failed to derive manifest version from %s\n' "${version}" >&2
  exit 1
fi

mkdir -p "${output_dir}" "${docker_context}"
cp -R "${template_root}" "${package_root}"
install -Dm0755 "${binary_path}" "${docker_context}/fileuni"

sed -i "s/__FILEUNI_VERSION__/${manifest_version}/g" "${package_root}/manifest.json"

image_tar="${stage_root}/docker_image.tar"

docker buildx build \
  --platform "${docker_platform}" \
  --file "${dockerfile_path}" \
  --tag fileuni-cli:ikuai \
  --output "type=docker,dest=${image_tar}" \
  "${docker_context}"

gzip -c "${image_tar}" > "${package_root}/docker_image.tar.gz"

tar -C "${stage_root}" -czf "${output_dir}/${artifact_base}.ipkg" "${package_name}"
