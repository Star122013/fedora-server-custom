FROM quay.io/fedora/fedora-bootc:44

COPY rootfs/ /

RUN dnf5 install 'dnf5-command(copr)' -y && \
  dnf copr enable zhullyb/v2rayA -y && \
  dnf install -y \
  linux-firmware iwlwifi-firmware \
  fastfetch curl ripgrep fd bat git helix \
  jq fzf btop zoxide tmux git-delta \
  podman podman-compose \
  dae

RUN systemctl enable bootc-fetch-apply-updates.timer

RUN bootc container lint
