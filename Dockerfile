FROM ubuntu:22.04

# 1. அடிப்படைத் தேவைகளை நிறுவுதல்
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    tar \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# 2. Gotty-ஐ சரியான லிங்க் மூலம் நிறுவுதல் (Broken link சரி செய்யப்பட்டது)
RUN curl -L https://github.com \
    | tar -xz -C /usr/local/bin

# 3. Wings-க்கு தேவையான ஃபோல்டர்களை உருவாக்குதல்
RUN mkdir -p /etc/pterodactyl /var/lib/pterodactyl /var/log/pterodactyl

# 4. Wings பைனரியை முன்கூட்டியே டவுன்லோட் செய்தல்
RUN curl -L -o /usr/local/bin/wings "https://github.com" \
    && chmod +x /usr/local/bin/wings

# 5. போர்ட் எக்ஸ்போஸ் (Render $PORT-ஐ தானாக கவனிக்கும்)
EXPOSE 8080

# 6. Gotty-ஐ உங்கள் பாஸ்வேர்ட் மூலம் பாதுகாப்பாக தொடங்குதல்
# 'admin' என்பது யூசர்நேம், நீங்கள் கொடுத்தது பாஸ்வேர்ட்
CMD gotty -p $PORT -c "admin:#startupgamer12" bash
