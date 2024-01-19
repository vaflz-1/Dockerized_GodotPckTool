FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    wget \
    zsh \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN wget "https://github.com/hhyyrylainen/GodotPckTool/releases/download/v1.9/godotpcktool" -O /usr/local/bin/godotpcktool \
    && chmod +x /usr/local/bin/godotpcktool

WORKDIR /app

CMD ["/usr/bin/zsh"]
