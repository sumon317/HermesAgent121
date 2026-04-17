# Hermes Gateway on Render (Free, No Credit Card)

## Files in this repo
```
Dockerfile              - container build instructions
requirements.txt        - Python deps (hermes-ai + python-telegram-bot)
config.template.yaml    - Hermes config with ${ENV_VAR} placeholders
start.sh                - injects env vars, starts pinger + hermes gateway
render.yaml             - Render deploy config
```

---

## Step 1 — Get a Telegram Bot Token

1. Open Telegram → search **@BotFather**
2. Send `/newbot`
3. Give it a name (e.g. `MyHermes`) and a username (e.g. `myhermes_bot`)
4. BotFather replies with a token like `7412345678:AAFxxxxxxxxxxxxxxxxxxxxxx`
5. **Save this token** — you'll need it in Step 3

---

## Step 2 — Push this repo to GitHub

```bash
git init
git add .
git commit -m "hermes render deploy"
# create a new repo on github.com (name it hermes-gateway or anything)
git remote add origin https://github.com/YOURUSERNAME/hermes-gateway.git
git push -u origin main
```

**IMPORTANT:** Do NOT put your API keys in any file. They go in Render's env vars only.

---

## Step 3 — Deploy on Render

1. Go to https://render.com → Sign up with GitHub (no CC needed for free tier)
2. Click **New → Web Service**
3. Connect your GitHub repo
4. Render auto-detects the `Dockerfile`
5. Set these **Environment Variables** in the Render dashboard:
   - `MISTRAL_API_KEY` → `UZ1LKWVgXWXgmJr5em4BWjzUmDMJtijJ`
   - `TELEGRAM_BOT_TOKEN` → the token from BotFather
6. Click **Deploy**

---

## Step 4 — Set up UptimeRobot (prevents Render sleep)

Render free tier sleeps after 15 min of inactivity. UptimeRobot pings it every 5 min to keep it awake.

1. Go to https://uptimerobot.com → Sign up (free, no CC)
2. Click **Add New Monitor**
3. Type: **HTTP(s)**
4. URL: your Render service URL (looks like `https://hermes-gateway-xxxx.onrender.com`)
5. Monitoring interval: **5 minutes**
6. Save

That's it. UptimeRobot pings port 8080 every 5 min → Render stays awake → Hermes runs 24/7.

---

## Usage

Once deployed, just open Telegram and chat with your bot. It goes through:

```
You (Telegram) → Render (Hermes gateway) → Mistral API → reply back to you
```

---

## Changing the model

Send `/model` in Telegram to your bot (if Hermes supports it), or change
`model.default` in `config.template.yaml`, commit, and Render auto-redeploys.

---

## Limits on Render Free

- 512 MB RAM — enough for hermes gateway (no local inference)
- 0.1 CPU — fine for API-only usage
- Sleeps without UptimeRobot pinger (that's why Step 4 matters)
# HermesAgent121
