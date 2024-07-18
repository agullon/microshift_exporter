
GO           ?= go

go_build:
	$(GO) build .

rpm_build:
	bash rpm_build.sh

rpm_build: image_push

image_build:
	podman build -t microshift-exporter .

image_push: image_build
	podman push microshift-exporter:latest quay.io/agullon/microshift-exporter:latest

deploy:
	oc apply -f microshift-exporter.yaml

delete:
	oc delete -f microshift-exporter.yaml

restart: delete deploy
