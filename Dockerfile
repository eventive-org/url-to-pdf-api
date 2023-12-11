FROM browserless/chrome:latest

ENV BROWSER_EXECUTABLE_PATH=$CHROME_PATH
ENV PORT=9000

USER root

RUN addgroup app && \ 
    useradd --gid app --shell /bin/bash --create-home app

USER app

WORKDIR /home/app

RUN git clone --depth 1 https://github.com/eventive-org/_fonts.git && \
    bash ./_fonts/bin/compile /home/app

WORKDIR /app

COPY --chown=app:app . .

RUN npm install --only=production

EXPOSE 9000
CMD [ "node", "." ]
