# sabi-railway

پروژه تستی دانشگاه تهران — Blue Knight Gate، آماده‌سازی‌شده برای Railway.

این ریپو شامل `index.js`، `package.json`، `Dockerfile` و `railway.json` است. Railway با اتصال به همین ریپو build و start را خودکار انجام می‌دهد.

## راهنمای فارسی

راهنمای کامل نصب، Deploy، Volume، Domain، متغیرهای محیطی، تست و رفع خطا در فایل [راهنمای فارسی](docs/DEPLOY_FA.md) قرار دارد.

خلاصه مراحل:

1. در Railway یک Project جدید بسازید.
2. گزینه Deploy from GitHub repo را انتخاب و `sabi-karami/sabi-railway` را متصل کنید.
3. صبر کنید Docker build و Deploy تمام شود.
4. در Service Settings → Volumes یک Volume با mount path `/data` بسازید.
5. در Networking یک Domain ایجاد کنید.
6. آدرس Domain را باز کنید و `/health` را برای تست سلامت بررسی کنید.

## English guide

The complete deployment, volume, domain, environment-variable, testing, and troubleshooting instructions are in [the English guide](docs/DEPLOY_EN.md).

## One-line manual deploy

From a terminal where the Railway CLI is installed, run:

```bash
git clone https://github.com/sabi-karami/sabi-railway.git && cd sabi-railway && railway up -y
```

The command signs you in if needed, creates/links a Railway project, and deploys the current directory. It does not create a public domain automatically; add a domain from Railway Networking afterward.

## Important notes

- The service uses Railway's assigned `PORT` automatically.
- Persistent data and downloaded binaries are stored under `/data/bk-data` when a Railway Volume is mounted at `/data`.
- The web panel is exposed through the Railway HTTP domain. TCP-based protocols require Railway TCP Proxy and may have platform-specific limitations.
- Never commit passwords, tokens, private keys, or other secrets to GitHub. Use Railway Variables instead.
