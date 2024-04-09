# This is a Dockerfile for developing in rust. It includes the rust toolchain, cargo, rust-analyzer, and clippy.
# It also includes the necessary dependencies for building the project, and exposes a port to ssh into the container.

# Use the official rust image as the base image
FROM rust:latest

# Set the working directory to /app
WORKDIR /app

# Arguments for disabling SSL verification
ARG SSL_VERIFY=true

# set environment variables for rust-analyzer, neovim, and the ssh port
ENV RUST_ANALYZER_VERSION=2024-04-08
ENV RUST_ANALYZER_ARCHITECTURE=x86_64-unknown-linux-gnu
ENV NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
ENV SSH_PORT=2222


# Install the necessary dependencies for building the project and hosting an ssh server
RUN export DEBIAN_FRONTEND=noninteractive \
    && if ${SSL_VERIFY}; then \
        apt-get update \
        && apt-get install -y \
            clang \
            cmake \
            libssl-dev \
            curl \
            git \
            zsh \
            openssh-server \
            pkg-config; \
    else \
        apt-get update -o Acquire::https::Verify-Peer=false \
        && apt-get install -y -o Acquire::https::Verify-Peer=false \
            clang \
            cmake \
            libssl-dev \
            curl \
            git \
            zsh \
            openssh-server \
            pkg-config; \
        fi \
    && rm -rf /var/lib/apt/lists/*

# Install `install_dotfiles` script from aaweaver-actuary/dotfiles repo
RUN dotrepo="http://github.com/aaweaver-actuary/dotfiles" \
    && if ${SSL_VERIFY}; then \
        curl -L ${dotrepo}/install_dotfiles -o /tmp/install_dotfiles; \
    else \
        curl -L ${dotrepo}/install_dotfiles -o /tmp/install_dotfiles --insecure; \
        fi \
    && chmod +x /tmp/install_dotfiles \
    && mv /tmp/install_dotfiles /usr/bin/install_dotfiles \
    && # Install dotfiles and load other scripts
    && install_dotfiles ~ .zshrc .zsh_aliases ban_ssl install_nvim nvim.tar.gz install_oh_my_zsh .hushlogin install_rust_analyzer \
    && chmod +x ban_ssl install_nvim install_oh_my_zsh install_rust_analyzer \
    && mv ban_ssl /usr/bin/ban_ssl \
    && exec zsh \
    && source ./install_oh_my_zsh \
    && install_dotfiles ~ .zshrc .zsh_aliases \
    && exec zsh \
    && source ./install_nvim \
    && source ./install_rust_analyzer \
    && rm -rf /tmp/*
    && rm install_nvim install_oh_my_zsh install_rust_analyzer

# Expose the ssh port
EXPOSE ${SSH_PORT}

# Start the ssh server
CMD ["/usr/sbin/sshd", "-D"]


# Install rust-analyzer & clippy
RUN rust_analyzer_url="https://github.com/rust-lang/rust-analyzer/releases/download/${RUST_ANALYZER_VERSION}/rust-analyzer-${RUST_ANALYZER_ARCHITECTURE}.gz" \
    && if ${SSL_VERIFY}; then \
        curl -L ${rust_analyzer_url} -o /tmp/rust-analyzer.gz; \
    else \
        curl -L ${rust_analyzer_url} -o /tmp/rust-analyzer.gz --insecure; \
        fi \
    && gunzip /tmp/rust-analyzer.gz \
    && chmod +x /tmp/rust-analyzer \
    && mv /tmp/rust-analyzer /usr/bin/rust-analyzer

# Install clippy
