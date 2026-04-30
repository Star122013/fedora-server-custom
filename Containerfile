FROM quay.io/fedora/fedora-bootc:44

COPY rootfs/ /

# Package groups:
# - firmware coverage for common PCIe/USB network adapters
# - network stack and diagnostics
# - hardware/storage inspection tools
# - terminal/editor utilities
# - container tooling and dae
RUN dnf5 install 'dnf5-command(copr)' -y && \
  dnf copr enable zhullyb/v2rayA -y && \
  dnf copr enable -y cnachen/mihomo && \
  dnf update -y linux-firmware && \
  dnf install -y \
  linux-firmware \
  iwlwifi-mvm-firmware \
  kernel-modules-extra \
  NetworkManager-wifi wpa_supplicant usb_modeswitch iw \
  pciutils usbutils ethtool iproute iputils bind-utils \
  dmidecode smartmontools nvme-cli mtr tcpdump traceroute \
  fastfetch curl ripgrep fd bat git helix \
  jq fzf btop zoxide tmux git-delta \
  podman podman-compose \
  dae dnsmasq mihomo && \
  dnf clean all

RUN systemctl enable bootc-fetch-apply-updates.timer

RUN bootc container lint
