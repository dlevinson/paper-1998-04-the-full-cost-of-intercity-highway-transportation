# REFORMAT f3.a
# \015 is OCTAL (not decimal) for ^M, \012 is OCTAL for ^J LF
# awk program to reformat UNIX files on Macintosh to PC readable
# DML 8.17.95
BEGIN { RS="\015"
        ORS="\012" 
        print FILENAME}
#
{ {print $0 }}
END {}
