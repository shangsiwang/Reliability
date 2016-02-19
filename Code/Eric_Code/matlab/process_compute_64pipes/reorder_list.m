function [str1, str3, list1, list3] = reorder_list(str1, str2, list1, list2)
str3num=1;
list3=zeros(length(str1),1);
str3=cell(length(str1),1);
for i=1:length(str1)
    idx=find(strcmp(str2', cellstr(str1{i})));
    str3(str3num)=str2(idx);
    list3(str3num)=list2(idx);
    str3num=str3num+1;
    
end
