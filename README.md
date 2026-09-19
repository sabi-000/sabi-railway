# sabi-railway

پروژه تستی دانشگاه تهران — Blue Knight Gate، آماده‌سازی‌شده برای Railway.

## Deploy سریع

در Railway گزینه **Deploy from GitHub repo** را انتخاب کنید و این repository را متصل کنید. Railway با `railway.json` و `Dockerfile` به‌صورت خودکار build و اجرا می‌کند.

پس از deploy:

1. در Service Settings → Networking یک Domain بسازید.
2. برای نگهداری state و باینری‌ها یک Volume با mount path `/data` اضافه کنید.
3. مقدار `BK_DATA_DIR=/data/bk-data` از قبل تنظیم شده است.
4. در صورت نیاز، TCP Proxy را برای پورت داخلی سرویس فعال کنید.

برنامه پورت اختصاص‌داده‌شده توسط Railway (`PORT`) را استفاده می‌کند و endpoint سلامت آن `/health` است.
