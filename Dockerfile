FROM ghcr.io/puppeteer/puppeteer:21.6.0

ENV PORT=9000
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

USER root

USER pptruser

WORKDIR /home/pptruser

RUN git clone --depth 1 https://github.com/eventive-org/_fonts.git && \
    bash ./_fonts/bin/compile /home/pptruser

WORKDIR /app

COPY --chown=pptruser:pptruser . .

RUN npm install --only=production

EXPOSE 9000
CMD [ "node", "." ]
