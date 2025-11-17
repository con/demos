## List of the commands (with timing after #) executed in the asciinema:

```source /home/austin/devel/demos/sfn-2025/venv/bin/activate```      # 0.05 sec

```mkdir -p /home/austin/tmp```      # 0.06 sec

```cd /home/austin/tmp```      # 0.06 sec

```datalad create -c text2git myproject```      # 0.93 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```cd myproject```      # 0.06 sec

```mkdir -p outputs```      # 0.05 sec

```datalad install -d . -s https://github.com/ReproNim/ds000003-demo sourcedata/raw```      # 1.41 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```datalad run -m 'Check BOLD file metadata' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz duct -- nib-ls sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz```      # 2.21 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```con-duct ls```      # 0.15 sec

```datalad run -m 'Check file size' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz duct -- du -sh sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz```      # 0.44 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```con-duct ls -f summaries```      # 0.14 sec

```datalad run -m 'Compress BOLD file' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz --output outputs/sub-02_bold.nii.gz duct -- bash -c 'gzip -c sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz > outputs/sub-02_bold.nii.gz'```      # 1.15 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```ls -lh outputs/```      # 0.06 sec

```git --no-pager log --oneline -n 5```      # 0.06 sec

```datalad run -m 'Extract brain mask' --input sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz --output outputs/mask.nii.gz duct -- python /home/austin/devel/demos/sfn-2025/scripts/extract_mask.py sourcedata/raw/sub-02/func/sub-02_task-rhymejudgment_bold.nii.gz outputs/mask.nii.gz```      # 0.63 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```con-duct ls```      # 0.16 sec

```cd /home/austin/tmp```      # 0.05 sec

```datalad clone https://cerebra.fz-juelich.de/f.hoffstaedter/ds000007-mriqc.git ds000007-mriqc-hoffstaedter```      # 10.86 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```cd ds000007-mriqc-hoffstaedter```      # 0.05 sec

```datalad get logs/duct/*.json```      # 14.29 sec [help](http://docs.datalad.org/en/latest/generated/man/datalad-.html)

```git --no-pager log --oneline | head -20```      # 0.05 sec

```con-duct ls logs/duct/*```      # 0.17 sec

```con-duct ls logs/duct/* -f json_pp | head -50```      # 0.16 sec

```con-duct plot logs/duct/sub-01_2025.10.10T00.36.37-3899234_usage.json -o /home/austin/devel/demos/sfn-2025/outputs/mriqc-resources.png```      # 1.01 sec

```echo '=== Duct execution logs from MRIQC dataset ==='```      # 0.06 sec

```con-duct ls /home/austin/tmp/ds000007-mriqc-hoffstaedter/logs/duct/* -f summaries | head -20```      # 0.15 sec

```git -C /home/austin/tmp/ds000007-mriqc-hoffstaedter --no-pager log --oneline | head -20```      # 0.05 sec

