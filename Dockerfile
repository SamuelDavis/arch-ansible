FROM archlinux

ENV USERNAME="user"

RUN pacman --sync --refresh --sysupgrade --noconfirm
RUN pacman --sync --refresh --sysupgrade --noconfirm sudo
RUN pacman --sync --refresh --sysupgrade --noconfirm --needed ansible-core ansible
RUN pacman --sync --refresh --sysupgrade --noconfirm --needed git base-devel
RUN echo "Defaults         lecture = never" > /etc/sudoers.d/privacy \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel \
    && useradd --create-home --groups wheel --shell /bin/bash ${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}
RUN git clone https://aur.archlinux.org/yay-bin.git
RUN cd yay-bin \
    && makepkg --install --syncdeps --noconfirm \
    && cd .. \
    && rm -r yay-bin

CMD bash
