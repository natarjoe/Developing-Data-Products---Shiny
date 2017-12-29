Dog Breeds
========================================================
author: Joseph Natarajan
date: 12/29/17
autosize: true

Looking for the perfect Puppy !
========================================================

Searching for the perfect puppy can be a time consuming task since many factors have to be taken into account like life style, preferences,etc.

This app will help you narrow your search.It has details for about 100 breeds and can be searched by height, weight and intelligence.


Interactive Application
========================================================

To view the app and search the Dogs database please click the following link

https://natarjoe.shinyapps.io/Dog_Breed/

Data for this Project
========================================================

Data Source:

The data for this visual is available in https://data.world/ 

1) AKC Breed Info.csv 2) dog_intelligence.csv 


```r
#setwd("~/R/Dog/Dog")


  
  df1<-read.csv(file="AKC Breed Info_r.csv",sep = ",",header=TRUE,stringsAsFactors=FALSE)
  
  df1$Breed <- toupper(df1$Breed) 
  df2<-read.csv(file="Breed_intelligence_r.csv",sep = ",",header=TRUE,stringsAsFactors=FALSE)
  
  df2$Breed <- toupper(df2$Breed) 
  
  df<-merge(df1, df2, all.x = TRUE,by =c("Breed"))
  df$Classification<-as.factor(df$Classification)
  
  df[df == '#N/A'] <- NA
  df[df == 'n/a'] <- NA
  df[df == 'na'] <- NA
  df[df == 'not found'] <- NA
  df[df == 'VIZSLA'] <- NA # Appears to have incorrect data for this breed . Height shown  is 66 inches !. 
  df <- df[complete.cases(df), ]
  
  df$height_low_inches<-as.numeric(df$height_low_inches)
  df$height_high_inches<-as.numeric(df$height_high_inches)
  
  
  
  
  df$height_inches <- (df$height_low_inches + df$height_high_inches)/2 # Average Height
  
  
  df$weight_low_lbs<-as.numeric(df$weight_low_lbs)
  df$weight_high_lbs<-as.numeric(df$weight_high_lbs)
  
  df$weight_lbs <- (df$weight_low_lbs+df$weight_high_lbs)/2 # Average Weight
  
  df <- df[,c("Breed","height_inches","weight_lbs","Classification")]
  
  df
```

```
                             Breed height_inches weight_lbs
1                    AFFENPINSCHER          10.5       10.0
3                  AIRDALE TERRIER          23.0       45.0
4                            AKITA          27.0      100.0
7                AMERICAN FOXHOUND          23.5       67.5
8   AMERICAN STAFFORDSHIRE TERRIER          18.0       45.0
9           AMERICAN WATER SPANIEL          16.5       35.0
11               AUSTRALIAN CATTLE          18.5       40.0
12             AUSTRALIAN SHEPHERD          20.5       50.0
13              AUSTRALIAN TERRIER          10.0       12.0
17                  BEARDED COLLIE          21.0       50.0
19              BEDLINGTON TERRIER          15.5       20.5
20                BELGIAN MALINOIS          24.0       62.5
21                BELGIAN SHEEPDOG          24.0       67.5
22                BELGIAN TERVUREN          24.0       67.5
23                BERNESE MOUNTAIN          25.0       97.5
24                    BICHON FRISE          10.5       14.0
25         BLACK AND TAN COONHOUND          25.0       62.5
28                   BORDER COLLIE          20.0       40.0
29                  BORDER TERRIER          13.5       13.5
31                  BOSTON TERRIER          14.5       20.0
32            BOUVIER DES FLANDRES          25.0       85.0
33                           BOXER          23.0       67.5
34                          BRIARD          25.0       75.0
35                        BRITTANY          19.0       35.0
37                    BULL TERRIER          21.5       60.0
39                     BULLMASTIFF          26.0      115.0
40                   CAIRN TERRIER           9.5       14.0
42            CARDIGAN WELSH CORGI          11.0       30.0
43   CAVALIER KING CHARLES SPANIEL          12.5       17.5
44        CHESAPEAKE BAY RETRIEVER          23.5       65.0
45                       CHIHUAHUA           7.5        3.5
46                 CHINESE CRESTED          12.0        8.5
47                CHINESE SHAR PEI          19.0       50.0
49                 CLUMBER SPANIEL          19.5       50.0
50                  COCKER SPANIEL          15.5       25.0
51                          COLLIE          24.0       62.5
53          CURLY COATED RETRIEVER          26.0       72.5
54                       DACHSHUND           8.5       24.0
55                       DALMATIAN          21.0       57.5
56          DANDIE DINMONT TERRIER          21.0        9.5
57               DOBERMAN PINSCHER          27.0       80.0
58                ENGLISH FOXHOUND          23.5       67.5
59                  ENGLISH SETTER          25.0       62.5
60        ENGLISH SPRINGER SPANIEL          20.0       50.0
62                   FIELD SPANIEL          18.0       42.5
63                   FINNISH SPITZ          17.5       33.0
65            FOX TERRIER (SMOOTH)          14.5       17.5
66              FOX TERRIER (WIRE)          14.5       17.5
67                  FRENCH BULLDOG          11.5       22.5
68                 GERMAN SHEPHERD          24.0       82.5
69      GERMAN SHORTHAIRED POINTER          23.5       65.0
70       GERMAN WIREHAIRED POINTER          24.0       65.0
71                 GIANT SCHNAUZER          26.5       72.5
73                GOLDEN RETRIEVER          22.5       65.0
74                   GORDON SETTER          25.0       62.5
75                      GREAT DANE          32.0      140.0
76                  GREAT PYRENEES          29.5      107.5
78                       GREYHOUND          28.5       65.0
80                    IBIZAN HOUND          25.5       48.5
81                    IRISH SETTER          26.0       65.0
82                   IRISH TERRIER          18.5       26.0
83             IRISH WATER SPANIEL          16.5       55.0
84                 IRISH WOLFHOUND          31.5      120.0
85               ITALIAN GREYHOUND          13.5        8.0
86                   JAPANESE CHIN           9.5        7.5
87                        KEESHOND          18.0       42.5
88              KERRY BLUE TERRIER          19.0       37.5
90                          KUVASZ          29.0       95.0
91              LABRADOR RETRIEVER          22.5       67.5
92                LAKELAND TERRIER          13.5       16.0
93                         MALTESE           9.0        5.0
94              MANCHESTER TERRIER          15.5       17.5
97                    NEWFOUNDLAND          27.0      125.0
98              NORWEGIAN ELKHOUND          19.5       50.0
100           OLD ENGLISH SHEEPDOG          22.0       62.5
101                    OTTER HOUND          25.0       87.5
102                       PAPILLON           9.5        7.5
104                  PHARAOH HOUND          23.0       50.0
106                        POINTER          22.5       55.0
108                     POMERANIAN          12.0        5.0
109                         POODLE          20.0       45.0
110               PORTUGUESE WATER          21.5       51.0
111                            PUG          10.5       18.0
112                           PULI          16.5       31.0
114            RHODESIAN RIDGEBACK          25.5       77.5
115                     ROTTWEILER          24.5      100.0
116                  SAINT BERNARD          26.5      150.0
117                         SALUKI          25.5       52.5
118                        SAMOYED          21.5       57.5
119                     SCHIPPERKE          11.5       15.0
120             SCOTTISH DEERHOUND          30.0       92.5
121               SCOTTISH TERRIER          11.0       20.0
122               SEALYHAM TERRIER          12.0       19.0
123    SHETLAND SHEEPDOG (SHELTIE)          14.5       17.0
124                      SHIBA INU          14.5       22.5
126                 SIBERIAN HUSKY          21.5       50.0
128                   SKYE TERRIER          10.0       25.0
129    SOFT-COATED WHEATEN TERRIER          19.0       40.0
131     STAFFORDSHIRE BULL TERRIER          15.0       26.0
132             STANDARD SCHNAUZER          18.0       33.0
135                TIBETAN SPANIEL          10.0       12.0
136                TIBETAN TERRIER          15.5       25.0
138                     WEIMARANER          26.0       77.5
139         WELSH SPRINGER SPANIEL          17.5       40.0
140                  WELSH TERRIER          15.0       20.5
141    WEST HIGHLAND WHITE TERRIER          11.0       14.0
142                        WHIPPET          20.0       28.5
143    WIREHAIRED POINTING GRIFFON          22.0       52.5
144              YORKSHIRE TERRIER           8.0        5.0
                            Classification
1               Above Average Working Dogs
3               Above Average Working Dogs
4   Average Working/Obedience Intelligence
7   Average Working/Obedience Intelligence
8               Above Average Working Dogs
9   Average Working/Obedience Intelligence
11                          Brightest Dogs
12  Average Working/Obedience Intelligence
13              Above Average Working Dogs
17              Above Average Working Dogs
19  Average Working/Obedience Intelligence
20                  Excellent Working Dogs
21                  Excellent Working Dogs
22                  Excellent Working Dogs
23                  Excellent Working Dogs
24  Average Working/Obedience Intelligence
25  Average Working/Obedience Intelligence
28                          Brightest Dogs
29              Above Average Working Dogs
31  Average Working/Obedience Intelligence
32              Above Average Working Dogs
33  Average Working/Obedience Intelligence
34              Above Average Working Dogs
35                  Excellent Working Dogs
37     Fair Working/Obedience Intelligence
39     Fair Working/Obedience Intelligence
40              Above Average Working Dogs
42                  Excellent Working Dogs
43  Average Working/Obedience Intelligence
44              Above Average Working Dogs
45     Fair Working/Obedience Intelligence
46     Fair Working/Obedience Intelligence
47  Average Working/Obedience Intelligence
49              Above Average Working Dogs
50                  Excellent Working Dogs
51                  Excellent Working Dogs
53  Average Working/Obedience Intelligence
54  Average Working/Obedience Intelligence
55              Above Average Working Dogs
56     Fair Working/Obedience Intelligence
57                          Brightest Dogs
58  Average Working/Obedience Intelligence
59              Above Average Working Dogs
60                  Excellent Working Dogs
62              Above Average Working Dogs
63  Average Working/Obedience Intelligence
65  Average Working/Obedience Intelligence
66  Average Working/Obedience Intelligence
67     Fair Working/Obedience Intelligence
68                          Brightest Dogs
69                  Excellent Working Dogs
70  Average Working/Obedience Intelligence
71              Above Average Working Dogs
73                          Brightest Dogs
74              Above Average Working Dogs
75  Average Working/Obedience Intelligence
76     Fair Working/Obedience Intelligence
78  Average Working/Obedience Intelligence
80  Average Working/Obedience Intelligence
81              Above Average Working Dogs
82  Average Working/Obedience Intelligence
83                  Excellent Working Dogs
84  Average Working/Obedience Intelligence
85     Fair Working/Obedience Intelligence
86     Fair Working/Obedience Intelligence
87                  Excellent Working Dogs
88              Above Average Working Dogs
90  Average Working/Obedience Intelligence
91                          Brightest Dogs
92     Fair Working/Obedience Intelligence
93     Fair Working/Obedience Intelligence
94              Above Average Working Dogs
97              Above Average Working Dogs
98              Above Average Working Dogs
100    Fair Working/Obedience Intelligence
101 Average Working/Obedience Intelligence
102                         Brightest Dogs
104             Above Average Working Dogs
106 Average Working/Obedience Intelligence
108                 Excellent Working Dogs
109                         Brightest Dogs
110             Above Average Working Dogs
111    Fair Working/Obedience Intelligence
112             Above Average Working Dogs
114 Average Working/Obedience Intelligence
115                         Brightest Dogs
116    Fair Working/Obedience Intelligence
117 Average Working/Obedience Intelligence
118             Above Average Working Dogs
119                 Excellent Working Dogs
120 Average Working/Obedience Intelligence
121    Fair Working/Obedience Intelligence
122    Fair Working/Obedience Intelligence
123                         Brightest Dogs
124 Average Working/Obedience Intelligence
126 Average Working/Obedience Intelligence
128    Fair Working/Obedience Intelligence
129 Average Working/Obedience Intelligence
131 Average Working/Obedience Intelligence
132                 Excellent Working Dogs
135 Average Working/Obedience Intelligence
136    Fair Working/Obedience Intelligence
138                 Excellent Working Dogs
139             Above Average Working Dogs
140 Average Working/Obedience Intelligence
141 Average Working/Obedience Intelligence
142 Average Working/Obedience Intelligence
143 Average Working/Obedience Intelligence
144             Above Average Working Dogs
```



Data for this Project (Data)
========================================================



```
                           Breed height_inches weight_lbs
1                  AFFENPINSCHER          10.5       10.0
3                AIRDALE TERRIER          23.0       45.0
4                          AKITA          27.0      100.0
7              AMERICAN FOXHOUND          23.5       67.5
8 AMERICAN STAFFORDSHIRE TERRIER          18.0       45.0
9         AMERICAN WATER SPANIEL          16.5       35.0
                          Classification
1             Above Average Working Dogs
3             Above Average Working Dogs
4 Average Working/Obedience Intelligence
7 Average Working/Obedience Intelligence
8             Above Average Working Dogs
9 Average Working/Obedience Intelligence
```


Code for this Project
========================================================

https://github.com/natarjoe/Developing-Data-Products---Shiny 
