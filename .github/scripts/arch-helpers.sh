#!/usr/bin/env bash

fileuni_normalize_arch() {
  local arch_raw="${1:-}"

  case "${arch_raw}" in
    x86_64)
      printf '%s\n' "x86_64"
      ;;
    i686)
      printf '%s\n' "x86_32"
      ;;
    aarch64|arm64)
      printf '%s\n' "aarch64"
      ;;
    *)
      printf '%s\n' "${arch_raw}"
      ;;
  esac
}

fileuni_build_base() {
  local product="${1:-}"
  local arch="${2:-}"
  local os="${3:-}"
  local libc="${4:-}"

  printf '%s\n' "FileUni-${product}-${arch}-${os}-${libc}"
}

fileuni_detect_os_default() {
  local target="${1:-}"

  if [[ "${target}" == *windows* ]]; then
    printf '%s\n' "windows"
  elif [[ "${target}" == *apple-darwin* ]]; then
    printf '%s\n' "macos"
  elif [[ "${target}" == *linux-android* ]]; then
    printf '%s\n' "android"
  elif [[ "${target}" == *freebsd* ]]; then
    printf '%s\n' "freebsd"
  elif [[ "${target}" == *linux* ]]; then
    printf '%s\n' "linux"
  else
    printf '%s\n' "unknown"
  fi
}

fileuni_detect_libc_default() {
  local target="${1:-}"

  if [[ "${target}" == *musl* ]]; then
    printf '%s\n' "musl"
  elif [[ "${target}" == *gnu* ]]; then
    printf '%s\n' "gnu"
  elif [[ "${target}" == *msvc* ]]; then
    printf '%s\n' "msvc"
  elif [[ "${target}" == *darwin* ]]; then
    printf '%s\n' "darwin"
  elif [[ "${target}" == *android* ]]; then
    printf '%s\n' "android"
  elif [[ "${target}" == *freebsd* ]]; then
    printf '%s\n' "freebsd"
  else
    printf '%s\n' "native"
  fi
}

fileuni_detect_os_gui() {
  local target="${1:-}"

  if [[ "${target}" == *windows* ]]; then
    printf '%s\n' "windows"
  elif [[ "${target}" == *apple-darwin* ]]; then
    printf '%s\n' "macos"
  elif [[ "${target}" == *linux* ]]; then
    printf '%s\n' "linux"
  else
    printf '%s\n' "unknown"
  fi
}

fileuni_detect_libc_gui() {
  local target="${1:-}"

  if [[ "${target}" == *musl* ]]; then
    printf '%s\n' "musl"
  elif [[ "${target}" == *gnu* ]]; then
    printf '%s\n' "gnu"
  elif [[ "${target}" == *msvc* ]]; then
    printf '%s\n' "msvc"
  elif [[ "${target}" == *darwin* ]]; then
    printf '%s\n' "darwin"
  else
    printf '%s\n' "native"
  fi
}

fileuni_detect_linux_package_libc() {
  local target="${1:-}"

  if [[ "${target}" == *musl* ]]; then
    printf '%s\n' "musl"
  elif [[ "${target}" == *gnu* ]]; then
    printf '%s\n' "gnu"
  else
    printf '%s\n' "linux"
  fi
}

fileuni_cli_base() {
  local target="${1:-}"
  local variant="${2:-default}"
  local arch

  arch="$(fileuni_normalize_arch "${target%%-*}")"

  case "${variant}" in
    default)
      fileuni_build_base "cli" "${arch}" "$(fileuni_detect_os_default "${target}")" "$(fileuni_detect_libc_default "${target}")"
      ;;
    android)
      fileuni_build_base "cli" "${arch}" "android" "cli"
      ;;
    freebsd)
      fileuni_build_base "cli" "${arch}" "freebsd" "freebsd"
      ;;
    linux-packages)
      fileuni_build_base "cli" "${arch}" "linux" "$(fileuni_detect_linux_package_libc "${target}")"
      ;;
    openwrt)
      fileuni_build_base "cli" "${arch}" "openwrt" "musl"
      ;;
    ikuai)
      fileuni_build_base "cli" "${arch}" "ikuai" "ipkg"
      ;;
    *)
      printf 'Unknown cli base variant: %s\n' "${variant}" >&2
      return 1
      ;;
  esac
}

fileuni_is_openwrt_cli_target() {
  local target="${1:-}"

  case "${target}" in
    x86_64-unknown-linux-musl|aarch64-unknown-linux-musl|i686-unknown-linux-musl|armv7-unknown-linux-musleabihf)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

fileuni_is_ikuai_cli_target() {
  fileuni_is_openwrt_cli_target "$@"
}

fileuni_docker_platform() {
  local target="${1:-}"

  case "${target}" in
    x86_64-unknown-linux-musl)
      printf '%s\n' "linux/amd64"
      ;;
    i686-unknown-linux-musl)
      printf '%s\n' "linux/386"
      ;;
    aarch64-unknown-linux-musl)
      printf '%s\n' "linux/arm64"
      ;;
    armv7-unknown-linux-musleabihf)
      printf '%s\n' "linux/arm/v7"
      ;;
    *)
      printf 'Unsupported Docker target: %s\n' "${target}" >&2
      return 1
      ;;
  esac
}

fileuni_gui_base() {
  local target="${1:-}"
  local variant="${2:-default}"
  local arch

  arch="$(fileuni_normalize_arch "${target%%-*}")"

  case "${variant}" in
    default)
      fileuni_build_base "gui" "${arch}" "$(fileuni_detect_os_gui "${target}")" "$(fileuni_detect_libc_gui "${target}")"
      ;;
    windows-msvc)
      fileuni_build_base "gui" "${arch}" "windows" "msvc"
      ;;
    android)
      fileuni_build_base "gui" "${arch}" "android" "app"
      ;;
    ios-app)
      fileuni_build_base "gui" "${arch}" "ios" "app"
      ;;
    macos-app)
      fileuni_build_base "gui" "${arch}" "macos" "app"
      ;;
    *)
      printf 'Unknown gui base variant: %s\n' "${variant}" >&2
      return 1
      ;;
  esac
}

fileuni_luci_base() {
  fileuni_build_base "luci-app" "all" "openwrt" "luci"
}
