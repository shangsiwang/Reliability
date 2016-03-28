function [strlist, list1, list2,str1] = compare_pipe(filestr,cmpval,cmpstr,mnrval)

num1=1;str1=cell(32,1);
num2=1;str2=cell(32,1);
list1=zeros(32,1);
list2=zeros(32,1);
val=1;
for i =2:6
    if (i~=cmpval)
        list(val) = i;
        val=val+1;
    end
end
a=list(1);b=list(2);c=list(3);d=list(4);

cstr=filestr{1,cmpval};
numpipes=length(filestr);
for i=1:numpipes
    if (strcmp(filestr{i,cmpval},cmpstr)==1)
        list1(num1) = mnrval(i);
        str1(num1) = cellstr(strcat(filestr{i,a},'.',filestr{i,b},'.',filestr{i,c},'.',filestr{i,d}));
        num1=num1+1;
    else
        list2(num2) = mnrval(i);
        str2(num2) = cellstr(strcat(filestr{i,a},'.',filestr{i,b},'.',filestr{i,c},'.',filestr{i,d}));
        num2=num2+1;
    end
end
% % to check whether the result is valid...
if (min(cellfun(@strcmp, str2, str1))==0)
    if (length(str2)~=length(str1))
        error('Mistakes were made!');
    end
    [str1, str2, list1, list2] = reorder_list(str1,str2,list1,list2);
end

assert(min(cellfun(@strcmp,str2,str1))==1);  
strlist=str2;
