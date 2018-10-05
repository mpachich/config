FROM python:3.6
RUN mkdir -p /python_code/src
WORKDIR /python_code/src
COPY index.html /python_code/src/index.html
COPY config.yaml config.yaml
EXPOSE 8000
CMD ["python","-m","http.server"]