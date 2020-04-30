#! /bin/bash
daywOnlyFor=Jan/2019
log_file_source=access.log
log_file_api=${log_file_source}.stage1.API
log_file_vi=${log_file_api}.stage2.vi
log_file_solrcruz=${log_file_api}.stage2.solrcruz
log_file_project=${log_file_api}.stage2.project

# take log only from API
cat $log_file_source       | grep $daywOnlyFor | grep -i "$keyword" $1 >  ${log_file_api}
cat $log_file_source.1     | grep $daywOnlyFor | grep -i "$keyword" $1 >> ${log_file_api}
zcat $log_file_source.*.gz | grep $daywOnlyFor | grep -i "$keyword" $1 >> ${log_file_api}


# take vintage only :
keyword='POST /solr/vintage/select'
cat $log_file_api | grep -i "$keyword" $1 > ${log_file_vi}
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "log analysis for ${log_file_vi}"
bash do_analysis_for_single_log_file.sh ${log_file_vi}
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# take project only: 
keyword='POST /solr/project'
cat $log_file_api | grep -i "$keyword" $1 > ${log_file_project}
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "log analysis for ${log_file_project}"
bash do_analysis_for_single_log_file.sh ${log_file_project}
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# take solrcruz only:
keyword='POST /solr/solrcruz/'
cat $log_file_api | grep -i "$keyword" $1 > ${log_file_solrcruz}
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "log analysis for ${log_file_solrcruz}"
bash do_analysis_for_single_log_file.sh ${log_file_solrcruz}
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
