FROM python:3.14.7-alpine3.24@sha256:05b2b8b732ecd268fee8727a369f936f022d1321b59befd13c30ede22769dcdc

LABEL repository="https://github.com/EnricoMi/publish-unit-test-result-action"
LABEL homepage="https://github.com/EnricoMi/publish-unit-test-result-action"
LABEL maintainer="Enrico Minack <github@Enrico.Minack.dev>"

LABEL com.github.actions.name="Publish Test Results"
LABEL com.github.actions.description="A GitHub Action to publish test results."
LABEL com.github.actions.icon="check-circle"
LABEL com.github.actions.color="green"

RUN apk add --no-cache --upgrade expat libuuid

COPY python/requirements-post-3.9.txt /action/requirements.txt
RUN apk add --no-cache build-base libffi-dev; \
    pip install --upgrade --force --no-cache-dir pip && \
    pip install --upgrade --force --no-cache-dir -r /action/requirements.txt; \
    apk del build-base libffi-dev

COPY python/publish /action/publish
COPY python/publish_test_results.py /action/

ENTRYPOINT ["python", "/action/publish_test_results.py"]
