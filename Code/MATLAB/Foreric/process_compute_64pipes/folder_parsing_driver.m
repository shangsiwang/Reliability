dataset='KKI';

pipes=['pipeline_abide_run__ANTS/                     '; 'pipeline_abide_run__ANTS__freq-filter/        '; ...
     'pipeline_abide_run__ANTS__scrub/              '; 'pipeline_abide_run__ANTS__freq-filter__scrub/ ';  ...
     'pipeline_abide_run__FNIRT/                    '; 'pipeline_abide_run__FNIRT__freq-filter/       '; ...
     'pipeline_abide_run__FNIRT__scrub/             '; 'pipeline_abide_run__FNIRT__freq-filter__scrub/'];
%pipes=['pipeline_abide_run__ANTS__freq-filter__scrub/'];

pipes=cellstr(pipes);

nuis=['_compcor_ncomponents_5_selector_pc10.linear1.wm0.global0.motion1.quadratic1.gm0.compcor1.csf0/'; ...
      '_compcor_ncomponents_5_selector_pc10.linear1.wm0.global1.motion1.quadratic1.gm0.compcor1.csf0/'];
%nuis=['_compcor_ncomponents_5_selector_pc10.linear1.wm0.global1.motion1.quadratic1.gm0.compcor1.csf0/'];

nuis=cellstr(nuis);
 
masks=['_mask_aal_mask_pad/                  '; '_mask_CC200/                         ';...
        '_mask_ho_mask_pad/                   '; '_mask_MNI152_T1_3mm_desikan_adjusted/'];
%masks=['_mask_MNI152_T1_3mm_desikan_adjusted/'];

masks=cellstr(masks); 
 
files=[];
i=1;
strname=cell(numel(pipes)*numel(nuis)*numel(masks),1);

for x=1:numel(pipes)
    for y=1:numel(nuis)
        for z=1:numel(masks)
            tfiles=dir(strcat(pipes{x}, nuis{y}, masks{z}, '*.mat'));
            for k=1:length(tfiles)
                tfiles(k).name=strcat(pipes{x},nuis{y},masks{z},tfiles(k).name);
            end
           
            files=[files; tfiles];
            strname(i)=cellstr(strcat(dataset, num2str(x), num2str(y),num2str(z)));
            i=i+1;
        end
    end
end


[mnrfull, tvals, mnrval, tvalmax,roinum] = process_dataset_nbin(files, 42,64,210, 1, strname);

