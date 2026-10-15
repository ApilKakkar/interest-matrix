# Interest Matrix

A 2×2 drill-down map of my interests — same UI as the ml_ops_finance Information Box (teal theme, zoom navigation, breadcrumbs, search, deep links).

It is a single self-contained page: `index.html`. All content is the `DATA` tree at the top of its `<script>`.

## Edit content
- Max 4 cards per level (2–4 preferred); regroup instead of adding a 5th.
- Leaf shape: `{ t, d, tag, facts?, list? }`. Tags: `dec` Core · `chk` Learning · `idea` Curious · `later` Someday.
- Add a Changelog entry (Beyond Work → Notebook → Changelog) for every update.

## Run locally
```bash
python3 -m http.server 8000      # then open http://localhost:8000
```

## Docker
```bash
docker compose up --build        # http://localhost:8080
docker compose --profile dev up web-dev   # live edits, no rebuild → http://localhost:8081
```
Plain Docker:
```bash
docker build -t interest-matrix .
docker run --rm -p 8080:8080 interest-matrix
```
The image is unprivileged nginx serving `index.html`, listens on `$PORT` (default 8080), exposes `/healthz`.

## Deploy

**1. Google Cloud Run** (same as ml_ops_finance)
```bash
gcloud run deploy interest-matrix --source . --region asia-south1 --allow-unauthenticated
```
Or from a built image: `gcloud run deploy interest-matrix --image ghcr.io/apilkakkar/interest-matrix:latest --region asia-south1 --allow-unauthenticated` (the GHCR package must be public, or use Artifact Registry).

**2. Any Docker host / VPS**
```bash
docker pull ghcr.io/apilkakkar/interest-matrix:latest
docker run -d --restart unless-stopped -p 80:8080 ghcr.io/apilkakkar/interest-matrix:latest
```

**3. CI image build**
`.github/workflows/docker.yml` builds the image on every push/PR, smoke-tests `/healthz`, and on pushes to `main` publishes `ghcr.io/apilkakkar/interest-matrix:latest` (+ commit SHA tag). No secrets needed; it uses the built-in `GITHUB_TOKEN`.

## Files
| File | Purpose |
|---|---|
| `index.html` | The whole app |
| `Dockerfile`, `docker/nginx.conf.template` | Image + nginx config |
| `docker-compose.yml` | Local run + dev profile |
| `.github/workflows/docker.yml` | Build, test, publish image |
