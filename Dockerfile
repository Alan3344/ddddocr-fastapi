# 使用官方 Python 运行时作为父镜像
FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 将当前目录内容复制到容器的 /app 中
COPY . /app

# 安装项目依赖
RUN pip install --no-cache-dir -r requirements.txt \
apt update && apt install -y sudo curl lsof net-toolsls \
&& curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb \
&& sudo dpkg -i cloudflared.deb \
&& rm -f cloudflared.deb \
&& cloudflared --version

# 暴露端口 8010
EXPOSE 8010

# 运行应用
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8010"]
