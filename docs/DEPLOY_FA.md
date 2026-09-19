# راهنمای کامل اجرای sabi-railway روی Railway

## وضعیت آماده‌سازی

این ریپو برای Deploy خودکار آماده شده است:

- `Dockerfile`: ساخت image و اجرای Node.js
- `railway.json`: انتخاب Dockerfile، دستور start و health check
- `package.json`: وابستگی‌ها و `npm start`
- `index.js`: استفاده از `PORT` اختصاص‌داده‌شده توسط Railway
- `BK_DATA_DIR=/data/bk-data`: مسیر ذخیره state و باینری‌ها

## مراحل Deploy

1. وارد [Railway](https://railway.com) شوید.
2. یک Project جدید ایجاد کنید.
3. گزینه **Deploy from GitHub repo** را بزنید.
4. ریپوی `sabi-karami/sabi-railway` را انتخاب کنید.
5. صبر کنید تا Docker build و Deploy موفق شود.

Railway به‌صورت خودکار `railway.json` را می‌خواند و `npm start` را اجرا می‌کند.

## دستور یک‌خطی برای Deploy دستی

اگر Railway CLI روی سیستم نصب است، این دستور را در Terminal اجرا کنید:

```bash
git clone https://github.com/sabi-karami/sabi-railway.git && cd sabi-railway && railway up -y
```

این دستور در صورت نیاز ورود به Railway را انجام می‌دهد، پروژه/سرویس را می‌سازد یا به آن متصل می‌شود و کد را Deploy می‌کند. Domain عمومی خودکار ساخته نمی‌شود؛ بعد از Deploy از بخش Networking یک Domain بسازید.

## Volume الزامی

برای حفظ state، UUIDها، لاگ‌ها و باینری‌های دانلودشده:

1. وارد Service شوید.
2. از Settings یا Command Palette گزینه Volume را اضافه کنید.
3. Mount path را دقیقاً `/data` بگذارید.
4. سرویس را Redeploy کنید.

متغیر `BK_DATA_DIR=/data/bk-data` در Dockerfile تنظیم شده است.

## Domain و تست

از Service → Settings → Networking گزینه **Generate Domain** را بزنید. سپس این آدرس‌ها را تست کنید:

- `https://YOUR-DOMAIN/`
- `https://YOUR-DOMAIN/knight`
- `https://YOUR-DOMAIN/health`

در پاسخ health باید JSON شامل `ok: true` دیده شود.

## TCP Proxy

پنل وب از HTTP/HTTPS استفاده می‌کند. برای ترافیک خام TCP باید در Railway بخش TCP Proxy را فعال کنید و پورت داخلی سرویس را انتخاب کنید. Railway یک hostname و port عمومی مخصوص TCP می‌دهد؛ همان port باید در کلاینت استفاده شود.

به‌دلیل محدودیت‌های شبکه Railway، ممکن است همه پروتکل‌های TCP یا TLS/SNI مانند یک VPS عمل نکنند. ابتدا `/health` و پنل وب را بررسی کنید.

## متغیرهای محیطی پیشنهادی

در Railway → Variables تنظیم کنید:

```text
NODE_ENV=production
BK_DATA_DIR=/data/bk-data
PANEL_TOKEN=یک-توکن-قوی-و-تصادفی
```

توکن را در GitHub ننویسید. برای فعال/غیرفعال کردن پروتکل‌ها، متغیرهای `ENABLE_*` پروژه را در Railway تنظیم کنید.

## عیب‌یابی

- اگر health check شکست خورد: Logs را ببینید و بررسی کنید سرویس روی `0.0.0.0` و `PORT` اجرا شده باشد.
- اگر بعد از Restart تنظیمات از بین رفت: Volume به `/data` متصل نیست.
- اگر پنل باز می‌شود اما TCP کار نمی‌کند: TCP Proxy و port عمومی تولیدشده Railway را بررسی کنید.
- اگر build شکست خورد: از Logs خطای Docker/npm را بررسی کنید و دوباره Deploy کنید.

## امنیت

رمز عبور، token، UUID خصوصی و کلیدها را commit نکنید. همه secrets را فقط در Railway Variables نگه دارید و در صورت عمومی بودن ریپو، دسترسی آن را بررسی کنید.
