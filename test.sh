#!/bin/bash
cd $(dirname $0)

IMAGE=myelintek/rocm-llm-dev:latest

[ ! -e hg_hub_cache ] && mkdir hg_hub_cache
[ ! -e log ] && mkdir log

docker run -it --rm -v $(pwd)/log:/log \
	-v $(pwd)/hg_hub_cache:/root/.cache/huggingface \
	--device /dev/kfd --device /dev/dri/renderD128 \
	$IMAGE \
	sh -c "rocm-smi && cd transformers/tests/quantization/bnb && sed -i 's/@/#@/g' test_mixed_int8.py &&  pytest -r A -o log_cli=true test_mixed_int8.py 2>&1|tee /log/test_mixed_int8.py.log "
