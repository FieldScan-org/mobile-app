FROM python:3.12

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


RUN mkdir keys && cd keys && openssl genrsa -out private.pem 2048 && \
    openssl rsa -in private.pem -pubout -out public.pem

COPY . .

EXPOSE 8080 8080

CMD ["uvicorn", "src.main:app", "--reload", "--port", "8080", "--host", "0.0.0.0"]