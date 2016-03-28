function [strat, list1,list2,list3,list4,str2,str3,str4]=compare_atlas(filestr,cmpval,mnrval)


num1=1;str1=cell(16,1);list1=zeros(16,1);
num2=1;str2=cell(16,1);list2=zeros(16,1);
num3=1;str3=cell(16,1);list3=zeros(16,1);
num4=1;str4=cell(16,1);list4=zeros(16,1);

list=cell(4,1);
for i=1:4
    list(i)=cellstr(filestr{i,cmpval});
end

at1=cellstr(list(1));at2=cellstr(list(2));at3=cellstr(list(3));at4=cellstr(list(4));
val=1;
list=zeros(4,1);
for i =2:6
    if (i~=cmpval)
        list(val) = i;
        val=val+1;
    end
end

a=list(1);b=list(2);c=list(3);d=list(4);
numpipes=length(mnrval);
assert(strcmp(at1,'aal')==1);
assert(strcmp(at2,'CC200')==1);
assert(strcmp(at3,'ho')==1);
assert(strcmp(at4,'desik')==1);
for i=1:numpipes
    if strcmp(filestr{i,cmpval},at1)==1
        list1(num1)=mnrval(i);
        str1(num1)=cellstr(strcat(filestr{i,a},'.',filestr{i,b},'.',filestr{i,c},'.',filestr{i,d}));
        num1=num1+1;
    elseif strcmp(filestr{i,cmpval},at2)==1
        list2(num2)=mnrval(i);
        str2(num2)=cellstr(strcat(filestr{i,a},'.',filestr{i,b},'.',filestr{i,c},'.',filestr{i,d}));
        num2=num2+1;
    elseif strcmp(filestr{i,cmpval},at3)==1
        list3(num3)=mnrval(i);
        str3(num3)=cellstr(strcat(filestr{i,a},'.',filestr{i,b},'.',filestr{i,c},'.',filestr{i,d}));
        num3=num3+1;
    elseif strcmp(filestr{i,cmpval},at4)==1
        list4(num4)=mnrval(i);
        str4(num4)=cellstr(strcat(filestr{i,a},'.',filestr{i,b},'.',filestr{i,c},'.',filestr{i,d}));
        num4=num4+1;
    end
end

assert(min(cellfun(@strcmp,str1,str2))==1);
assert(min(cellfun(@strcmp,str1,str3))==1);
assert(min(cellfun(@strcmp,str1,str4))==1);
assert(min(cellfun(@strcmp,str2,str3))==1);
assert(min(cellfun(@strcmp,str2,str4))==1);
assert(min(cellfun(@strcmp,str3,str4))==1);

strat=str1;
end
