FROM  databricksruntime/standard:11.3-LTS
ENV PATH="${PATH}:/databricks/python3/bin"
# install dependencies
WORKDIR /usr/app/dbt

COPY models models
COPY seeds seeds
COPY tests tests
COPY snapshots snapshots
COPY macros macros
COPY dbt_project.yml dbt_project.yml
COPY Makefile Makefile
COPY profiles.yml profiles.yml
COPY packages.yml packages.yml
COPY requirements.txt requirements.txt

RUN apt update && apt install make

RUN /databricks/python3/bin/pip install -U pip
RUN /databricks/python3/bin/pip install -r requirements.txt
RUN dbt deps
