# Master's thesis
Repository for my MSc thesis

ScanCode LicenseDB data is licensed under the Creative Commons Attribution License 4.0 (CC-BY-4.0) by nexB Inc. and others.

`stage2.py` is licensed under AGPL-3.0.
## Build instructions
`sudo apt install texlive-full`

`latexmk`

To emulate the missing full license text stage 1, remove the `manual-licenses` directory.
## Timing

week n send first draft, wait for comments, revise

week n+1 send final draft, wait for final comments, revise

week n+2 read final comments, student sends final version, supervisor requests review

week n+3 wait for review

week n+4	wait for review

week n+5:

mon: supervisor sends thesis to grappa

wed: student submits thesis to E-thesis
## Thesis design
### 1 Introduction 6 pages
- setting
- definition
- problem
- easier sub-problem
- thesis' contribution
#### 1.1 Research goal, questions, and contributions
- primary object of this research (rqs)
- 1.2 will examine terms
- viewpoints
#### 1.2 Thesis structure
- thesis structure
#### 1.3 Background and terminology of public software licenses
- state of current terminology
- terms of other interest areas of the thesis
- why the scope is so narrow
- acknowledge some other essential but non-focus
- state of terminology standardization
- figure to demonstrate terms
- free vs open
- define public software licenses in se
- acknowledge the topic is complex
### 2 Methods 8 pages
- aim of the chapter
- explain slr
- study follows kitchenham 2007
- how the review process came to be
- reliability & validity
#### 2.1 Research questions
- purpose of rqs
- aim of individual rqs
#### 2.2 Search strategy
- where was search process conducted in (inclusion/exclusion in appendix a)
- data extraction process
##### 2.2.1 Search method
- more on where was search process conducted in
##### 2.2.2 Search scope and terms
- how were search terms determined (end condition)
- search string
- how many results
- finalized search string
#### 2.3 Search process
- Study selection divided into multiple stages (figure)
- first stage titles, abstracts and keywords
- second stage inclusion exclusion criteria (quality assesment incl/excl, manual excl in appendix b)
- third stage manual review (final list of licenses in appendix c (maybe in hosted javascript githubpages as well))
#### 2.4 Inclusion and exclusion criteria
- inclusion criterias (second phase from github /licenses api)
- exclusion criterias
- comments on applying
#### 2.5 Data collection and data analysis
- what was done to answer rq (table data extraction form)
- aim of scope and evidence levels (alves et al)
- categorization of results
- next chapter presents outcomes
### 3 Results 8 pages
- information about chapter
- how many licenses and why
- statistical overview with figures (mapping study)
- how many licenses during each stage (figure)
- basic statistic on final licenses (figure)
- essential statistics (figure)
#### 3.1 RQ1
- figures and study identifier tables
#### 3.2 RQ2
- figures and study identifier tables
#### 3.3 RQ3
- figures and study identifier tables
### 4 Discussion 7 pages
- indications
- follow-up observation
- observation 1
- observation 2
- sum-up from those two
#### 4.1 Implications for research
- how to improve scientific scene 1
- how to improve scientific scene 2
- how to improve scientific scene 3
#### 4.2 Implications for software engineering professionals
- how to improve professional scene 1
- how to improve professional scene 2
- how to improve professional scene 3
- overall
#### 4.3 Limitations and threats to validity
- major limitation
- possible threats to validity
##### 4.3.1 Limitations of license selection for review
- efforts to inclusion
- as with all slr all licenses cannot be reviewed manually
- license selection was done in sufficient manner
##### 4.3.2 Limitations in data extraction
- importance of data extraction
- lack of measurements and tooling
### 5 Conclusions 1 pages
- primary objective of this study
- conclusions from each rq
#### 5.1 Future research
- adopting a clear baseline
- Docker CLA, SSPL
- make cla easier maybe with gpg
- LICENSE highlighting.js
- what kind of efforts and why
- what this thesis has provided
- how has each license fared in the court in real life?