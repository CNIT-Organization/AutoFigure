FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    NODE_ENV=production \
    PORT=7860 \
    AUTOFIGURE_BACKEND_PORT=8796 \
    AUTOFIGURE_HOST=0.0.0.0 \
    NEXT_PUBLIC_AUTOFIGURE_BACKEND_URL=/backend \
    NEXT_TELEMETRY_DISABLED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY backend/requirements.txt backend/requirements.txt
RUN pip install --no-cache-dir -r backend/requirements.txt

RUN python -m playwright install --with-deps chromium

COPY frontend/package.json frontend/package.json
COPY frontend/package-lock.json frontend/package-lock.json
RUN cd frontend && npm ci

COPY . .

RUN cd frontend && npm run build
RUN chmod +x /app/start-space.sh

EXPOSE 7860

CMD ["/app/start-space.sh"]
