# Set Jupyter Notebook Root Directory on Host to be mounted in Docker
# such that all changes within Docker will be saved to local.
HOST_JUPYTER_NOTEBOOK_ROOT = $(PWD)/code
# if port 8888 on localhost has been used, change to another free port
CONTAINER_PORT = 8888

########################################
CONTAINER_NAME = notebook
CONTAINER_CODE_ROOT = /home/jovyan
CONTAINER_IMAGE = jupyter/all-spark-notebook

CMD_GET_CLASSIC_TOKEN = $(shell docker logs --tail 3 $(CONTAINER_NAME) 2>&1 | grep -o 'http://127.0.0.1:$(CONTAINER_PORT)/?token=.*')
CMD_GET_LAB_TOKEN = $(shell echo $(CMD_GET_CLASSIC_TOKEN) | sed 's/\/\?/\/lab\?/')

.PHONY: start
start:
	mkdir -p $(HOST_JUPYTER_NOTEBOOK_ROOT)
	docker run -d \
	  -p 127.0.0.1:$(CONTAINER_PORT):$(CONTAINER_PORT) \
	  --name=$(CONTAINER_NAME) \
	  --rm \
	  -v $(HOST_JUPYTER_NOTEBOOK_ROOT):$(CONTAINER_CODE_ROOT) \
	  $(CONTAINER_IMAGE)
	@echo "==> wait for server up ..." && sleep 3
	open $(CMD_GET_CLASSIC_TOKEN)
	open $(CMD_GET_LAB_TOKEN)
.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME)


.PHONY: clean
clean:
	docker rm $(CONTAINER_NAME)


.PHONY: restart
restart: | stop clean start
