FROM quay.io/fedora/fedora-bootc:43

COPY rootfs/ /

RUN dnf5 install 'dnf5-command(copr)' -y && \
  dnf copr enable zhullyb/v2rayA -y && \
  dnf install -y \
  fastfetch curl ripgrep fd bat git helix \
  podman podman-compose \
  dae 

RUN systemctl enable bootc-fetch-apply-updates.timer

RUN bootc container lint
