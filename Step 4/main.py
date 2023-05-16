import mysql.connector
from mysql.connector import Error
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import squarify
import numpy as np

try:
  cnx = mysql.connector.connect(host='localhost', database='world_analysis', user='root',password='169916')
  if cnx.is_connected():
    print("Connection Established")
    cursor = cnx.cursor()

    views = ['terrorism_happiness','military_details','happiness_gdp', 'corruption_migration', 'corruption_terrorism', 'gdp_rnd', 'happiness_corruption',
             'migration_poverty', 'migration_terrorism', 'poverty_militaryexpenditure']

    for view in views:
      query = f"SELECT * FROM {view}"
      cursor.execute(query)

      results = cursor.fetchall()

      df = pd.DataFrame(results, columns=[i[0] for i in cursor.description])

      if view == 'corruption_migration':
        plt.figure(figsize=(10, 6))
        sns.lineplot(data=df, x='years', y='corruption_percentage', hue='country_name')
        sns.lineplot(data=df, x='years', y='refugee_amount', hue='country_name')
        sns.lineplot(data=df, x='years', y='net_migration', hue='country_name')
        plt.title('Corruption, Refugee Amount and Net Migration Over Time')
        plt.show()
      elif view == 'terrorism_happiness':
        df['years'] = pd.to_datetime(df['years'], format='%Y')
        df['death'] = df['death'].astype(int)
        df['happiness_rate_out_of_10'] = df['happiness_rate_out_of_10'].astype(
          float)

        pivot_df_death = df.pivot(index='years', columns='country_name', values='death')
        pivot_df_happiness = df.pivot(index='years', columns='country_name', values='happiness_rate_out_of_10')


        pivot_df_death.plot(kind='area', stacked=False, alpha=0.5)
        plt.title('Deaths Over Time by Country')
        plt.ylabel('Number of Deaths')

        pivot_df_happiness.plot(kind='area', stacked=False, alpha=0.5)
        plt.title('Happiness Rate Over Time by Country')
        plt.ylabel('Happiness Rate')

        plt.show()
      elif view == 'corruption_terrorism':
        plt.figure(figsize=(10, 6))
        sns.scatterplot(data=df, x='corruption_percentage', y='death', hue='country_name')
        plt.title('Corruption vs Terrorism Deaths')
        plt.show()
      elif view == 'gdp_rnd':
        plt.figure(figsize=(10, 6))
        sns.barplot(data=df, x='country_name', y='gdp_growth')
        sns.barplot(data=df, x='country_name', y='RnD_expenditure_share_gdp')
        plt.title('GDP Growth vs R&D Expenditure')
        plt.show()
      elif view == 'happiness_corruption':
        plt.figure(figsize=(10, 6))
        sns.scatterplot(data=df, x='happiness_rate_out_of_10', y='corruption_percentage', hue='country_name')
        plt.title('Happiness vs Corruption')
        plt.show()
      elif view == 'happiness_gdp':
        df['happiness_rate_out_of_10'] = df['happiness_rate_out_of_10'].astype(
          float)
        df['gdp_growth'] = df['gdp_growth'].astype(float)

        df_melted = df.melt(id_vars='country_name', value_vars=['happiness_rate_out_of_10', 'gdp_growth'])

        plt.figure(figsize=(10, 6))
        sns.barplot(data=df_melted, x='country_name', y='value', hue='variable')
        plt.title('Happiness Rate and GDP Growth by Country')
        plt.show()
      elif view == 'migration_poverty':
        plt.figure(figsize=(10, 6))
        sns.barplot(data=df, x='country_name', y='share_of_pop_below_poverty')
        sns.barplot(data=df, x='country_name', y='refugee_amount')
        sns.barplot(data=df, x='country_name', y='net_migration')
        plt.title('Migration vs Poverty')
        plt.show()
      elif view == 'migration_terrorism':
        plt.figure(figsize=(10, 6))
        sns.lineplot(data=df, x='years', y='refugee_amount', hue='country_name')
        sns.lineplot(data=df, x='years', y='net_migration', hue='country_name')
        sns.lineplot(data=df, x='years', y='death', hue='country_name')
        plt.title('Migration vs Terrorism Over Time')
        plt.show()
      elif view == 'military_details':

        df['armed_personel_share_pop'] = df['armed_personel_share_pop'].astype(
          float)
        df['armed_personel_share_labor'] = df['armed_personel_share_labor'].astype(
          float)

        plt.figure(figsize=(10, 6))
        df.set_index('country_military_name')[['armed_personel_share_pop', 'armed_personel_share_labor']].plot(
          kind='barh', stacked=True)

        df['middle_y'] = df['armed_personel_share_pop'] + df['armed_personel_share_labor'] / 2

        for i, row in df.iterrows():
          plt.text(0.5, row['middle_y'], row['country_military_name'], ha='center')

        plt.title('Armed Personnel Share of Population and Labor by Country')
        plt.xlabel('Share')
        plt.ylabel('Country')
        plt.show()
      elif view == 'poverty_militaryexpenditure':
        plt.figure(figsize=(10, 6))
        sns.barplot(data=df, x='country_name', y='share_of_pop_below_poverty')
        sns.barplot(data=df, x='country_name', y='military_expenditure_share_gdp')
        plt.title('Poverty vs Military Expenditure')
        plt.show()

except mysql.connector.Error as err:
    print(err)
else:
  cnx.close()