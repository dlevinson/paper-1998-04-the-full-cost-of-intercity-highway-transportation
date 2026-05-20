BEGIN {}
# process time series data
# extract if year = 1988
{ if ( $(NF-8) == 1969 ) {print $0}}
END {}
