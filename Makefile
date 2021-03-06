# Set Jupyter Notebook Root Directory on Host to be mounted in Docker
# such that all changes within Docker will be saved to local.
HOST_JUPYTER_NOTEBOOK_ROOT = $(PWD)/code
# if port 8888 on localhost has been used, change to another free port
CONTAINER_PORT = 8888

########################################
CONTAINER_NAME = notebook
CONTAINER_CODE_ROOT = /home/jovyan/work
CONTAINER_TAG = latest
CONTAINER_IMAGE = cberthold/jupyter-dotnet
CONTAINER_BUILD = jupyter-dotnet

.PHONY: build
build:
	docker build -t ${CONTAINER_BUILD}:${CONTAINER_TAG} .

.PHONY: change-container
change-container:
	$(eval CONTAINER_IMAGE := "$(CONTAINER_BUILD)")
	
.PHONY: start-build
start-build: | change-container start

.PHONY: start
start:
	mkdir -p $(HOST_JUPYTER_NOTEBOOK_ROOT)
	docker run -d \
	  -p 127.0.0.1:$(CONTAINER_PORT):$(CONTAINER_PORT) \
	  --name=$(CONTAINER_NAME) \
	  --rm \
	  -v $(HOST_JUPYTER_NOTEBOOK_ROOT):$(CONTAINER_CODE_ROOT) \
	  $(CONTAINER_IMAGE):${CONTAINER_TAG}
	
.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME)


.PHONY: clean
clean:
	docker rm $(CONTAINER_NAME)

.PHONY: open
open:
	$(eval CMD_GET_TOKEN := $(shell docker exec -it $(CONTAINER_NAME) cat /home/jovyan/.local/share/jupyter/runtime/nbserver-6.json | jq --raw-output  ".token"))
	$(eval URL_JUPYTER_NB := "http://localhost:$(CONTAINER_PORT)/?token=$(CMD_GET_TOKEN)")
	$(eval URL_JUPYTER_LAB := "http://localhost:$(CONTAINER_PORT)/lab?token=$(CMD_GET_TOKEN)")
	open $(URL_JUPYTER_LAB)
	open $(URL_JUPYTER_NB)
.PHONY: restart
restart: | stop clean start
