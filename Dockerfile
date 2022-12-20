FROM python:3-alpine
WORKDIR /app
ADD app/hello.html /app
RUN adduser -Du 1001 web
USER 1001

CMD ["python","-m", "http.server", "8000"]
EXPOSE 8000