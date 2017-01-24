
import pandas as pd
import numpy as np
import csv
import pandas_profiling
import matplotlib.pyplot as plt
from scipy import stats
pd.set_option('display.max_rows', 500)
get_ipython().magic('matplotlib inline')


# In[2]:

datafile = open('C:/dsvm/notebooks/Data/theme_15_small_areas.csv', 'r')


# When reading csv into pandas, must get the character encoding right

# In[3]:

datafile2 = pd.read_csv('C:/dsvm/notebooks/Data/theme_15_small_areas.csv',
                        engine='python',
                        encoding='latin-1', 
                        header=0, 
                        names=['Datacode','SA_NAME','GEOGID','Electoral Division CSO Code','Electoral Division Name','County','NUTS_III','NUTS_II','Planning Region','Households_With_Cars_No_Motor_Car_2011','Households_With_Cars_One_Motor_Car_2011','Households_With_Cars_Two_Motor_Cars_2011','Households_With_Cars_Three_Motor_Cars_2011','Households_With_Cars_Four_Or_More_Motor_Cars_2011','Households_With_Cars_Total_2011','Perc_Households_With_Cars_No_Motor_Car_2011','Perc_Households_With_Cars_One_Motor_Car_2011','Perc_Households_With_Cars_Two_Motor_Cars_2011','Perc_Households_With_Cars_Three_Motor_Cars_2011','Perc_Households_With_Cars_Four_Or_More_Motor_Cars_2011','Households_With_Personal_Computer_Total_2011','Households_With_Personal_Computer_Yes_2011','Households_With_Personal_Computer_No_2011','Households_With_Personal_Computer_Not_Stated_2011','Perc_Households_With_Personal_Computer_Yes_2011','Perc_Households_With_Personal_Computer_No_2011','Perc_Households_With_Personal_Computer_Not_Stated_2011','Households_With_Internet_Access_Broadband_2011','Households_With_Internet_Access_Other_Connection_2011','Households_With_Internet_Access_No_Access_To_Internet_2011','Households_With_Internet_Access_Not_Stated_2011','Households_With_Internet_Access_Total_2011','Perc_Households_With_Internet_Access_Broadband_2011','Perc_Households_With_Internet_Access_Other_Connection_2011','Perc_Households_With_Internet_Access_No_Access_To_Internet_2011','Perc_Households_With_Internet_Access_Not_Stated_2011'],
                        index_col= 'Datacode',
                        skiprows=1,
                        skipfooter=1)




# In[4]:

datafile2.describe()


# In[5]:

pandas_profiling.ProfileReport(datafile2)


# In[75]:

df3 = datafile2[['NUTS_III','Perc_Households_With_Internet_Access_Broadband_2011']]


# In[76]:

df3.NUTS_III.unique()


# In[77]:

df3.describe()


# In[78]:

NUTS_III_group = {'South-East':'South', 
                      'South-West':'South', 
                      'Border':'Border-Mid-West',
                      'Mid-West':'Border-Mid-West', 
                      'West':'Border-Mid-West', 
                      'Mid-East':'Border-Mid-West', 
                      'Midlands':'Border-Mid-West',
                      'Dublin':'Dublin'}


 


# In[79]:

NUTS_III_group
df3["NUTS_III"].replace(NUTS_III_group, inplace=True)


# In[9]:

df3


# In[12]:

pandas_profiling.ProfileReport(df3)


# In[31]:

chart, ax = plt.subplots()


fit = np.polyfit(df3['Perc_Households_With_Internet_Access_Broadband_2011'], df3['Households_With_Cars_No_Motor_Car_2011'], deg=1)
ax.plot(df3['Perc_Households_With_Internet_Access_Broadband_2011'], fit[0] * df3['Households_With_Internet_Access_Total_2011'] + fit[1], color='blue')
ax.scatter(df3['Perc_Households_With_Internet_Access_Broadband_2011'], df3['Households_With_Cars_No_Motor_Car_2011'])

chart.show()



# In[81]:

df3.boxplot('Perc_Households_With_Internet_Access_Broadband_2011', by="NUTS_III", figsize=(12, 8))


# In[82]:

n=len(df3.index)
k=len(df3.iloc[1].unique())
dfB = k-1
dfW = n-k
xbarG = df3.mean().iloc[0]
alpha=0.05

#create a dict object containing the mean of each group (group by each value in column 1, iterate over the resulting tuples
# to convert to dict)
xbar=dict(df3.groupby(df3[df3.columns[0]])[df3.columns[1]].mean())

#COunt the number of observations in each group
ng=dict(df3.groupby(df3[df3.columns[0]])[df3.columns[1]].count())


df3['xminusxbar2'] = (lambda y: y**2)(df3[df3.columns[1]]- df3[df3.columns[0]].map(xbar))
#df3.xminusxbar2.sum()
MSSW = (df3.xminusxbar2.sum())/(n-k)

#Need ng(xbarg - xbarG)**2
xbar
ng
#Fstat = MSSB/MSSW

# Find the Critical Value for F

df3



# In[95]:


xbarG = 100
xbtemp = df3.groupby(df3[df3.columns[0]]).agg({df3.dtypes.index[1]: { 
                                                            "xbar" :"mean",
                                                            "ng" : "count",
                                                            "xminusxbarG2" : lambda q : (q.mean()-xbarG)**2
                                                            }
                                               }
                                              )
df3
xbtemp

#df3.merge(xbtemp, left_on=df3.columns[0], right_on=xbtemp.columns[0])


def my_anova1(observations, alpha):
    n = len(observations.index)
    k = len(observations.iloc[1].unique())
    dfB = k - 1
    dfW = n - k
    xbarG = observations.mean()

    # Group By Column 0
    # Calculate the Mean of column 1
    # We want to refer to columns by index so the function is generic
    # Test Case - what happens if the columns are in the wrong order
    # Test Case - What happens if there are more that 1 column
    group_stats = observations.groupby(observations[observations.columns[0]]).agg({observations.dtypes.index[1]: {
        "xbar": "mean",
        "ng": "count",
        "xminusxbarG2": lambda q: (q.mean() - xbarG) ** 2
    }
    })
    # Create a dictionary to hold xbar values for each group
    xbar = dict(observations.groupby(observations[observations.columns[0]])[observations.columns[1]].mean())

    observations['xminusxbar2'] = (lambda y: y ** 2)(
        observations[observations.columns[1]] - observations[observations.columns[0]].map(xbar))

    # Calculate Mean Sum of Squares within Groups
    MSSW = (observations.xminusxbar2.sum()) / (n - k)
    # MSSB = sum(ng * (xminusxbarG2))/k-1          
    # Fstat = MSSB/MSSW
