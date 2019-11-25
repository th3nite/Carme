#!/bin/bash 
IPADDR=$1
NB_PORT=$2
TB_PORT=$3
USER=$4
HASH=$5
GPUS=$6

chmod -R 1777 /tmp

# start theia ----------------------------------------------------------------------------------------------------------------------
THEIA_BASE_DIR="/opt/theia-ide/"
if [ -d ${THEIA_BASE_DIR} ]; then
  THEIA_JOB_TMP=${HOME}"/.local/share/carme/tmp-files-"${SLURM_JOB_ID}"/tmp_"${SLURM_JOB_ID}
  mkdir -p $THEIA_JOB_TMP
  cd ${THEIA_BASE_DIR}
  PATH=/opt/anaconda3/bin/:$PATH TMPDIR=$THEIA_JOB_TMP TMP=$THEIA_JOB_TMP TEMP=$THEIA_JOB_TMP /opt/anaconda3/bin/node node_modules/.bin/theia start ${HOME} --hostname $IPADDR --port $TA_PORT --startup-timeout -1 &
  cd
fi
#-----------------------------------------------------------------------------------------------------------------------------------


# start jupyter-lab ----------------------------------------------------------------------------------------------------------------
STOREDIR=${HOME}"/.local/share/carme/tmp-files-"${SLURM_JOB_ID}
/opt/anaconda3/bin/jupyter lab --ip=${IPADDR} --port=${NB_PORT} --notebook-dir=/home --no-browser --config=${STOREDIR}/jupyter_notebook_config-${SLURM_JOB_ID}.py --allow-root &
#-----------------------------------------------------------------------------------------------------------------------------------


# wait untill the job is done ------------------------------------------------------------------------------------------------------
wait
#-----------------------------------------------------------------------------------------------------------------------------------

