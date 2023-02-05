APP_NAME={{COMPOZE_SERVICE_NAME}}
TAG=latest
ACCOUNT_ID={{AWS_ACCOUNT_ID}}
REGION={{AWS_REGION}}

default: test build

build: 
	docker build . --tag ${APP_NAME}:${TAG}

test:
	@go test -v ./...

integration:
	echo "running integration tests"

run: build
	docker run  --name ${APP_NAME}  -p 8081:8080 -d ${TAG}

restart: build
	docker rm -f ${APP_NAME}
	docker run  --name ${APP_NAME}  -p 8081:8080 -d ${TAG}

deploy: build
	./scripts/login.sh ${ACCOUNT_ID} ${REGION}
	./scripts/push.sh ${ACCOUNT_ID} ${REGION} ${APP_NAME} $(ENVIRONMENT) ${TAG}
	./scripts/restart_service.sh ${APP_NAME} $(ENVIRONMENT)